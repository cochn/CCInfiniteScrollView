//
//  CCInfiniteScrollCell.h
//  CCInfiniteScrollView
//
//  Created by cc on 16/4/7.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCInfiniteScrollCell : UICollectionViewCell

@property(nonatomic,weak) UIImageView       *imageView;
@property(nonatomic,copy) NSString          *title;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;

@end
