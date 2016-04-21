//
//  CCInfiniteScrollCell.m
//  CCInfiniteScrollView
//
//  Created by cc on 16/4/7.
//  Copyright © 2016年 cochn. All rights reserved.
//

#import "CCInfiniteScrollCell.h"

@implementation CCInfiniteScrollCell

{
   __weak UILabel   *_titleLable;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpImageView];
        [self setUpTitleLable];
    }
    return self;
}

#pragma mark - init
- (void)setUpImageView{
    
    UIImageView *imageV = [[UIImageView alloc] init];
    _imageView = imageV;
    [self.contentView addSubview:self.imageView];
}

- (void)setUpTitleLable{
    
    UILabel *lable = [[UILabel alloc] init];
    _titleLable = lable;
    lable.textAlignment = NSTextAlignmentLeft;
    lable.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLable];
}

#pragma mark - setter
- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLable.text = title;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLable.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLable.font = titleLabelTextFont;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLable.backgroundColor = titleLabelBackgroundColor;
}

#pragma mark - layout
- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat imageVToLeft = 5;
    CGFloat imageVWidth  = 12;
    CGFloat imageVY      = (self.frame.size.height - imageVWidth)/2;
    _imageView.frame = CGRectMake(5, imageVY, imageVWidth, imageVWidth);

    CGFloat titleLableW = self.frame.size.width - imageVToLeft*3 - imageVWidth;
    CGFloat titleLableH = _titleLabelHeight;
    CGFloat titleLableX = imageVToLeft * 3+imageVWidth;
    CGFloat titleLableY = (self.frame.size.height-titleLableH)/2;
    _titleLable.frame = CGRectMake(titleLableX, titleLableY, titleLableW, titleLableH);
    
}

@end
