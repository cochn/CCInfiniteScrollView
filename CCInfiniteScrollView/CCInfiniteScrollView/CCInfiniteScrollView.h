//
//  CCInfiniteScrollView.h
//  CCInfiniteScrollView
//
//  Created by cc on 16/4/7.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCInfiniteScrollView;

@protocol CCInfiniteScrollViewDelegate <NSObject>

@optional

/** 点击回调 */
- (void)infiniteScrollView:(CCInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface CCInfiniteScrollView : UIView

/** 本地图片 */
@property(nonatomic,strong) UIImage     *localizationImage;
/** 要显示的文字数组 */
@property(nonatomic,strong) NSArray     *titleArray;

@property(nonatomic,weak)   id<CCInfiniteScrollViewDelegate>delegate;

/** 自动滚动间隔时间,默认2s */
@property(nonatomic,assign) CGFloat     autoScrollTimeInterval;
/** 是否无限循环,默认Yes */
@property(nonatomic,assign) BOOL        infiniteLoop;
/** 是否自动滚动,默认Yes */
@property(nonatomic,assign) BOOL        autoScroll;

/** 轮播文字label字体颜色 */
@property (nonatomic, strong) UIColor *titleLabelTextColor;
/** 轮播文字label字体大小 */
@property (nonatomic, strong) UIFont  *titleLabelTextFont;
/** 轮播文字label背景颜色 */
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
/** 轮播文字label高度 */
@property (nonatomic, assign) CGFloat titleLabelHeight;

/** 本地图片轮播初始化方式 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame;

@end
