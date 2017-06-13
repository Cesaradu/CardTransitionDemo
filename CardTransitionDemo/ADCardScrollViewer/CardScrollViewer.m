//
//  CardScrollViewer.m
//  Demo
//
//  Created by hztuen on 2017/6/8.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "CardScrollViewer.h"
#import "CardAnimationFlowLayout.h"
#import "CardAnimationCell.h"

@interface CardScrollViewer () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    CGFloat _dragStartX;
    CGFloat _dragEndX;
    NSInteger _currentIndex;
}

@property (nonatomic, strong) UIImageView *collectionBgView;//collectionView背景视图
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UISwipeGestureRecognizer *down;//下滑手势
@property (nonatomic, strong) UISwipeGestureRecognizer *up;//上滑手势

@end

@implementation CardScrollViewer

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initData];
        [self buildUI];
    }
    return self;
}

- (void)initData {
    self.imageArray = @[@"1", @"2", @"3", @"4", @"5", @"6"];
    
    //初始化collectionView背景视图
    self.collectionBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    //毛玻璃效果
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.collectionBgView.bounds;
    [self.collectionBgView addSubview:effectView];
}

- (void)buildUI {
    CardAnimationFlowLayout *layout = [[CardAnimationFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    self.collectionView.backgroundView = self.collectionBgView;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CardAnimationCell class] forCellWithReuseIdentifier:@"cellID"];
    [self addSubview:self.collectionView];
    
    //上滑手势
    self.up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
    self.up.direction = UISwipeGestureRecognizerDirectionUp;
    [self.collectionView addGestureRecognizer:self.up];
    
    //下滑手势
    self.down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    self.down.direction = UISwipeGestureRecognizerDirectionDown;
}

#pragma mark - SwipeGestureRecognizer 
- (void)swipeUp:(UISwipeGestureRecognizer *)swipeRecognizer {
    
    CGPoint location = [swipeRecognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    NSLog(@"向上滑动了%ld个item", indexPath.row);
    
    CardAnimationCell *swipeCell = (CardAnimationCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    //cell在当前collection的位置
    CGRect cellRect = [_collectionView convertRect:swipeCell.frame toView:_collectionView];
    //手势没在cell范围上
    if (cellRect.origin.x == 0 && cellRect.origin.y == 0) {
        return;
    }
    
    //手势没在当前 cell上
    if (indexPath.row != _currentIndex) {
        return;
    }
    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //coverImage
        CGRect frame = swipeCell.coverImage.frame;
        frame.origin.y -= [self Suit:100];
        swipeCell.coverImage.frame = frame;
        
        //bgView
        CGRect frame2 = swipeCell.bgView.frame;
        frame2.size = CGSizeMake(swipeCell.bgView.frame.size.width + [self Suit:30], swipeCell.bgView.frame.size.height + [self Suit:20]);
        frame2.origin.x -= [self Suit:15];
        swipeCell.bgView.frame = frame2;
        
        swipeCell.bgView.alpha = 1.0;
        
        //titleView
        CGRect frame3 = swipeCell.titleView.frame;
        frame3.size = CGSizeMake(swipeCell.titleView.frame.size.width + [self Suit:30], swipeCell.titleView.frame.size.height);
        frame3.origin.x -= [self Suit:15];
        swipeCell.titleView.frame = frame3;
        
    } completion:^(BOOL finished) {
        self.collectionView.scrollEnabled = NO;
        swipeCell.coverImage.userInteractionEnabled = YES;
        //上滑之后移除上滑手势避免继续上滑，并添加下滑手势
        [self.collectionView removeGestureRecognizer:self.up];
        [swipeCell addGestureRecognizer:self.down];
    }];
}

- (void)swipeDown:(UISwipeGestureRecognizer *)swipeRecognizer {
    CGPoint location = [swipeRecognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    NSLog(@"向下滑动了%ld个item", indexPath.row);
    
    CardAnimationCell *swipeCell = (CardAnimationCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //coverImage
        CGRect frame = swipeCell.coverImage.frame;
        frame.origin.y += [self Suit:100];
        swipeCell.coverImage.frame = frame;
        
        //bgView
        CGRect frame2 = swipeCell.bgView.frame;
        frame2.size = CGSizeMake(swipeCell.bgView.frame.size.width - [self Suit:30], swipeCell.bgView.frame.size.height - [self Suit:20]);
        frame2.origin.x += [self Suit:15];
        swipeCell.bgView.frame = frame2;
        
        swipeCell.bgView.alpha = 0.0;
        
        //titleView
        CGRect frame3 = swipeCell.titleView.frame;
        frame3.size = CGSizeMake(swipeCell.titleView.frame.size.width - [self Suit:30], swipeCell.titleView.frame.size.height);
        frame3.origin.x += [self Suit:15];
        swipeCell.titleView.frame = frame3;
        
    } completion:^(BOOL finished) {
        self.collectionView.scrollEnabled = YES;
        swipeCell.coverImage.userInteractionEnabled = NO;
        //下滑之后添加上滑手势，并移除下滑手势避免继续下滑
        [self.collectionView addGestureRecognizer:self.up];
        [swipeCell removeGestureRecognizer:self.down];
    }];
    
}


#pragma mark - UICollection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardAnimationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.tag = indexPath.row + 1000;
    [cell loadData:self.imageArray[indexPath.row]];
    
    cell.tapCoverImageBlock = ^(NSInteger tag) {
        if ([self.delegate respondsToSelector:@selector(CardScrollViewerDidSelectAtIndex:)]) {
            [self.delegate CardScrollViewerDidSelectAtIndex:tag];
        }
    };
    
    return cell;
}

#pragma mark - UIScrollView, 滚动时修正cell居中
//手指拖动开始
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _dragStartX = scrollView.contentOffset.x;
}

//手指拖动停止
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

//配置cell居中
-(void)fixCellToCenter
{
    //最小滚动距离
    float dragMiniDistance = self.collectionView.bounds.size.width/20.0f;
    if (_dragStartX -  _dragEndX >= dragMiniDistance) {
        _currentIndex -= 1;//向右
    }else if(_dragEndX -  _dragStartX >= dragMiniDistance){
        _currentIndex += 1;//向左
    }
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
    _currentIndex = _currentIndex <= 0 ? 0 : _currentIndex;
    _currentIndex = _currentIndex >= maxIndex ? maxIndex : _currentIndex;
    
    self.collectionBgView.image = [UIImage imageNamed:self.imageArray[_currentIndex]];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

/**
 适配 给定4.7寸屏尺寸，适配4和5.5寸屏尺寸
 */
- (float)Suit:(float)MySuit
{
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(MySuit=MySuit/Suit4Inch):((IS_IPHONE55INCH)?(MySuit=MySuit*Suit55Inch):MySuit);
    return MySuit;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
