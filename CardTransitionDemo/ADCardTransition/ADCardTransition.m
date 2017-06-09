//
//  ADCardTransition.m
//  CardTransitionDemo
//
//  Created by hztuen on 2017/6/9.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "ADCardTransition.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "CardAnimationCell.h"

@interface ADCardTransition ()

/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign) ADCardTransitionType type;

@end

@implementation ADCardTransition

+ (instancetype)transitionWithType:(ADCardTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(ADCardTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

/**
 *  动画时长
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6f;
}

/**
 *  如何执行过渡动画
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (_type) {
        case ADCardTransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
            
        case ADCardTransitionTypePop:
            [self popAnimation:transitionContext];
            break;
    }
}

/**
 *  执行push过渡动画
 */
- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    //起始页面
    FirstViewController *fromVC = (FirstViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //目标页面
    SecondViewController *toVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //不知道为什么， cellForItemAtIndexPath，取不到cell，cell为null
    //    CardAnimationCell *cell = (CardAnimationCell *)[fromVC.cardScrollViewer.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathWithIndex:fromVC.currentIndex]];
    
    //拿到当前点击的cell的imageView
    CardAnimationCell *cell;
    NSArray *cellArray = [fromVC.cardScrollViewer.collectionView visibleCells];
    for (int i = 0; i < cellArray.count; i++) {
        if (fromVC.currentIndex == [cellArray[i] tag] - 1000) {
            cell = (CardAnimationCell *)cellArray[i];
        }
    }
    
    UIView *containerView = [transitionContext containerView];
    //snapshotViewAfterScreenUpdates 对cell的imageView截图保存成另一个视图用于过渡，并将视图转换到当前控制器的坐标
    UIView *tempView = [cell.coverImage snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [cell.coverImage convertRect:cell.coverImage.bounds toView: containerView];
    
    //设置动画前的各个控件的状态
    cell.coverImage.hidden = YES;
    toVC.view.alpha = 0;
    toVC.topImageView.hidden = YES;
    
    //tempView 添加到containerView中，要保证在最前方，所以后添加
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    //开始做动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
        tempView.frame = [toVC.topImageView convertRect:toVC.topImageView.bounds toView:containerView];
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        tempView.hidden = YES;
        toVC.topImageView.hidden = NO;
        //如果动画过渡取消了就标记不完成，否则才完成，这里可以直接写YES，如果有手势过渡才需要判断，必须标记，否则系统不会中动画完成的部署，会出现无法交互之类的bug
        [transitionContext completeTransition:YES];
    }];
    
}

/**
 *  执行pop过渡动画
 */
- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    SecondViewController *fromVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FirstViewController *toVC = (FirstViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //不知道为什么， cellForItemAtIndexPath，取不到cell，cell为null
    //    CardAnimationCell *cell = (CardAnimationCell *)[toVC.cardScrollViewer.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathWithIndex:toVC.currentIndex]];
    
    //取到cell
    CardAnimationCell *cell;
    NSArray *cellArray = [toVC.cardScrollViewer.collectionView visibleCells];
    for (int i = 0; i < cellArray.count; i++) {
        if (toVC.currentIndex == [cellArray[i] tag] - 1000) {
            cell = (CardAnimationCell *)cellArray[i];
        }
    }
    
    UIView *containerView = [transitionContext containerView];
    //这里的lastView就是push时候初始化的那个tempView
    UIView *tempView = containerView.subviews.lastObject;
    //设置初始状态
    cell.coverImage.hidden = YES;
    fromVC.topImageView.hidden = YES;
    tempView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:1 / 0.55 options:0 animations:^{
        tempView.frame = [cell.coverImage convertRect:cell.coverImage.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        
        //由于加入了手势必须判断
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {//手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            tempView.hidden = YES;
            fromVC.topImageView.hidden = NO;
        } else {//手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
            cell.coverImage.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
    
}

@end
