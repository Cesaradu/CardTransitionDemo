//
//  ADCardTransition.h
//  CardTransitionDemo
//
//  Created by hztuen on 2017/6/9.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  动画过渡代理管理的是push还是pop
 */
typedef NS_ENUM(NSUInteger, ADCardTransitionType) {
    ADCardTransitionTypePush = 0,
    ADCardTransitionTypePop
};

@interface ADCardTransition : NSObject <UIViewControllerAnimatedTransitioning>

/**
 *  初始化动画过渡代理
 */
+ (instancetype)transitionWithType:(ADCardTransitionType)type;
- (instancetype)initWithTransitionType:(ADCardTransitionType)type;

@end
