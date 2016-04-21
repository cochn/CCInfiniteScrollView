//
//  CCInfiniteScrollView.m
//  CCInfiniteScrollView
//
//  Created by cc on 16/4/7.
//  Copyright © 2016年 cochn. All rights reserved.
//

#import "CCInfiniteScrollView.h"
#import "CCInfiniteScrollCell.h"

NSString *const collectionID = @"collectionID";

@interface CCInfiniteScrollView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,  weak) UICollectionView              *mainView;
@property(nonatomic,  weak) UICollectionViewFlowLayout    *flowLayout;
@property(nonatomic,  weak) NSTimer                       *timer;
@property(nonatomic,assign) NSInteger                     totalItemsCount;

@end

@implementation CCInfiniteScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
        [self setUpMainView];
    }
    return self;
}

- (void)initialization{
    
    _autoScrollTimeInterval     = 2;
    _infiniteLoop               = YES;
    _autoScroll                 = YES;
    
    _titleLabelTextColor        = [UIColor blackColor];
    _titleLabelTextFont         = [UIFont systemFontOfSize:14];
    _titleLabelBackgroundColor  = [UIColor whiteColor];
    _titleLabelHeight           = 35;
    
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame{
    CCInfiniteScrollView *scrollView = [[self alloc] initWithFrame:frame];
    return scrollView;
}

- (void)setUpMainView{
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 0;
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout = flow;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flow];
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[CCInfiniteScrollCell class] forCellWithReuseIdentifier:collectionID];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    _mainView = collectionView;
}

#pragma mark - setter

- (void)setInfiniteLoop:(BOOL)infiniteLoop{
    
    _infiniteLoop = infiniteLoop;
    
}

- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    [_timer invalidate];
    _timer = nil;
    
    if (_autoScroll) {
        [self setUpTimer];
    }
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval{
    
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self setAutoScroll:self.autoScroll];
}

- (void)setTitleArray:(NSArray *)titleArray{
    
    if (titleArray.count < _titleArray.count) {
        [_mainView setContentOffset:CGPointZero];
    }
    
    _titleArray = titleArray;
    
    _totalItemsCount = self.infiniteLoop ? titleArray.count * 100 : titleArray.count;
    
    if (titleArray.count != 1) {
        self.mainView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    }else{
        self.mainView.scrollEnabled = NO;
    }
    [self.mainView reloadData];
}

#pragma mark - actions

- (void)setUpTimer{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll{
    
    if (0 == _totalItemsCount) return;
    int currentIndex = _mainView.contentOffset.y / _flowLayout.itemSize.height;
    int targetIndex = currentIndex + 1;
    if (targetIndex == _totalItemsCount) {
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
        }else{
            return;
        }
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return;
    }
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - layout
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    if (_mainView.contentOffset.y == 0 && _totalItemsCount) {
        
        int targetIndex = 0;
        if (self.infiniteLoop) {
            targetIndex = _totalItemsCount * 0.5;
        }else{
            targetIndex = 0;
        }
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - public actions

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CCInfiniteScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    long itemIndex = indexPath.item % self.titleArray.count;
    
    NSString *titleStr = self.titleArray[itemIndex];
    
    cell.title = titleStr;
    cell.titleLabelHeight = self.titleLabelHeight;
    cell.titleLabelTextFont = self.titleLabelTextFont;
    cell.titleLabelTextColor = self.titleLabelTextColor;
    cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
    cell.imageView.image = _localizationImage;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didSelectItemAtIndex:)]) {
        [self.delegate infiniteScrollView:self didSelectItemAtIndex:indexPath.item%self.titleArray.count];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.autoScroll) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.autoScroll) {
        [self setUpTimer];
    }
}

#pragma mark - timer == nil
//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [_timer invalidate];
        _timer = nil;
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _mainView.delegate = nil;
    _mainView.dataSource = nil;
}












@end
