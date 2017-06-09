//
//  FirstViewController.h
//  CardTransitionDemo
//
//  Created by hztuen on 2017/6/9.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardScrollViewer.h"

@interface FirstViewController : UIViewController

@property (nonatomic, strong) CardScrollViewer *cardScrollViewer;

/**
 *  记录当前点击的indexPath
 */
@property (nonatomic, assign) NSInteger currentIndex;

@end
