//
//  ViewController.m
//  CCInfiniteScrollView
//
//  Created by cc on 16/4/7.
//  Copyright © 2016年 yggx. All rights reserved.
//

#import "ViewController.h"
#import "CCInfiniteScrollView.h"

@interface ViewController () <CCInfiniteScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self scrollView];
}

- (void)scrollView{
    
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com"
                        ];

    CCInfiniteScrollView *scrollView = [CCInfiniteScrollView cycleScrollViewWithFrame:CGRectMake(50, 100, self.view.frame.size.width-50, 35)];
    scrollView.localizationImage = [UIImage imageNamed:@"xx_ico"];
    scrollView.delegate = self;
    scrollView.titleArray = titles;
    [self.view addSubview:scrollView];
    
    
    
}

- (void)infiniteScrollView:(CCInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"这是第%ld个",(long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
