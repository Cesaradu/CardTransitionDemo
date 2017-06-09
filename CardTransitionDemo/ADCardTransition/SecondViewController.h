//
//  SecondViewController.h
//  CardTransitionDemo
//
//  Created by hztuen on 2017/6/9.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UINavigationControllerDelegate>

@property (nonatomic, assign) NSInteger index;//点击第几张
@property (nonatomic, strong) UIButton *backBtn;//返回按钮
@property (nonatomic, strong) UIImageView *topImageView;//顶部图片
@property (nonatomic, strong) UIView *titleView;//标题视图

@end
