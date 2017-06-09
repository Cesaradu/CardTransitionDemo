//
//  ShowStarView.m
//
//  Created by cesar on 16/11/28.
//  Copyright © 2016年 hztuen. All rights reserved.
//

#import "ShowStarView.h"

#define StartCount 5

@implementation ShowStarView

- (instancetype)init {
    if (self = [super init]) {
        self.distribution = UIStackViewDistributionEqualCentering;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.distribution = UIStackViewDistributionEqualCentering;
    }
    return self;
}

- (void)setLevel:(CGFloat)level{
    
    _level = level;
    //1.满星  把小数强转成NSInteger 成满星个数
    NSInteger fullStarCount = (NSInteger)level;
    for (NSInteger i = 0; i < fullStarCount; i++) {
        //添加满星
        [self makeStarViewWithImageName:@"comtent_star_icon" startPosition:i];
        
    }
    //2.半星   if成立表示有半星
    if (level - fullStarCount) {
        [self makeStarViewWithImageName:@"yiban_star_icon" startPosition:fullStarCount];
        fullStarCount ++;
    }
    //3.空星
    for (NSInteger i = fullStarCount; i < StartCount ; i++) {
        [self makeStarViewWithImageName:@"comtent_star_icon nal" startPosition:i];
    }
}

#pragma mark - 根据图片创建星星
- (void)makeStarViewWithImageName:(NSString *)imageName startPosition:(NSInteger) position {
    
    UIImageView *imageView = nil;
    if (self.subviews.count == StartCount) {
        imageView = self.subviews[position];
        imageView.image = [UIImage imageNamed:imageName];
        return;
    }
    
    imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:imageName];
    [self addArrangedSubview:imageView];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
