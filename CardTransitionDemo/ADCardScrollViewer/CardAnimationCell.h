//
//  CardAnimationCell.h
//  Demo
//
//  Created by hztuen on 2017/6/1.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowStarView.h"

@interface CardAnimationCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *favoriteLabel;
@property (nonatomic, strong) ShowStarView *starView;

@property (nonatomic, copy) void (^tapCoverImageBlock)(NSInteger tag);//点击图片

- (void)loadData:(NSString *)imageName;

@end
