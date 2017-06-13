//
//  FirstViewController.m
//  CardTransitionDemo
//
//  Created by hztuen on 2017/6/9.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface FirstViewController ()  <CardScrollDelegate, UINavigationControllerDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
}

- (void)buildUI {
    
    self.title = @"卡片";
    
    self.cardScrollViewer = [[CardScrollViewer alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.cardScrollViewer.delegate = self;
    [self.view addSubview:self.cardScrollViewer];
}

#pragma mark -CardScrollViewerDelegate
- (void)CardScrollViewerDidSelectAtIndex:(NSInteger)index {
    NSLog(@"点击了 %ld", index);
    self.currentIndex = index;
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.index = index;
    self.navigationController.delegate = secondVC;
    [self.navigationController pushViewController:secondVC animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
