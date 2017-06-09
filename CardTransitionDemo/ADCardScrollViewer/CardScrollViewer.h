//
//  CardScrollViewer.h
//  Demo
//
//  Created by hztuen on 2017/6/8.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardScrollDelegate <NSObject>

@optional

//滚动代理方法
- (void)CardScrollViewerDidSelectAtIndex:(NSInteger)index;

@end

@interface CardScrollViewer : UIView

@property (weak, nonatomic) id <CardScrollDelegate> delegate;

@property (nonatomic, strong) UICollectionView *collectionView;

@end
