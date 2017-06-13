//
//  SecondViewController.m
//  CardTransitionDemo
//
//  Created by hztuen on 2017/6/9.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "SecondViewController.h"
#import "ADCardTransition.h"
#import "ShowStarView.h"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation SecondViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self buildUI];
}

- (void)initData {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageArray = @[@"1", @"2", @"3", @"4", @"5", @"6"];
}

- (void)buildUI {
    
    [self buildTableHeadView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [self Suit:400], ScreenWidth, ScreenHeight-[self Suit:400])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.backBtn = [[UIButton alloc] init];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(27);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.width.height.mas_equalTo([self Suit:30]);
    }];
    
}

- (void)buildTableHeadView {
    
    //顶部图片
    self.topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageArray[self.index]]];
    self.topImageView.userInteractionEnabled = YES;
    self.topImageView.frame = CGRectMake(0, 0, ScreenWidth, [self Suit:300]);
    self.topImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.topImageView];
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, [self Suit:300], ScreenWidth, [self Suit:100])];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleView];
    
    UILabel *titleLabel = [UILabel labelWithTitle:@"This is a title, this is a title, this is a title" AndColor:@"515151" AndFont:16 AndAlignment:NSTextAlignmentLeft];
    [self.titleView addSubview:titleLabel];
    titleLabel.numberOfLines = 1;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).offset([self Suit:15]);
        make.left.equalTo(self.view.mas_left).offset([self Suit:15]);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    //价格
    UILabel *priceLabel = [UILabel labelWithTitle:@"Price: $1000.00" AndColor:@"8a8a8a" AndFont:15 AndAlignment:NSTextAlignmentLeft];
    [self.titleView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset([self Suit:5]);
        make.left.equalTo(titleLabel.mas_left);
    }];
    
    //评价
    UILabel *comment = [UILabel labelWithTitle:@"100 comments:" AndColor:@"8a8a8a" AndFont:14 AndAlignment:NSTextAlignmentLeft];
    [self.titleView addSubview:comment];
    [comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLabel.mas_bottom).offset([self Suit:15]);
        make.left.equalTo(self.titleView.mas_left).offset([self Suit:15]);
        make.height.mas_equalTo([self Suit:20]);
    }];
    
    //星星
    ShowStarView *starView = [[ShowStarView alloc] init];
    starView.level = 4;
    [self.titleView addSubview:starView];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(comment.mas_centerY);
        make.left.equalTo(comment.mas_right).offset([self Suit:10]);
        make.width.mas_equalTo([self Suit:70]);
        make.height.mas_equalTo([self Suit:20]);
    }];
    
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    
    
    return cell;
}

- (void)clickBackBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [ADCardTransition transitionWithType:operation == UINavigationControllerOperationPush ? ADCardTransitionTypePush : ADCardTransitionTypePop];
}

/**
 适配 给定4.7寸屏尺寸，适配4和5.5寸屏尺寸
 */
- (float)Suit:(float)MySuit
{
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(MySuit=MySuit/Suit4Inch):((IS_IPHONE55INCH)?(MySuit=MySuit*Suit55Inch):MySuit);
    return MySuit;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
