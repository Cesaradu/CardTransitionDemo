//
//  SecondViewController.m
//  CardTransitionDemo
//
//  Created by hztuen on 2017/6/9.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "SecondViewController.h"
#import "ADCardTransition.h"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

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
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [self buildTableHeadView];
    [self.view addSubview:self.tableView];
    
    self.backBtn = [[UIButton alloc] init];
    [self.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(27);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.width.height.mas_equalTo(30);
    }];
    
}

- (UIView *)buildTableHeadView {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 400)];
    headView.backgroundColor = [UIColor whiteColor];
    
    //顶部图片
    self.topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageArray[self.index]]];
    self.topImageView.userInteractionEnabled = YES;
    self.topImageView.frame = CGRectMake(0, 0, ScreenWidth, 300);
    self.topImageView.contentMode = UIViewContentModeScaleToFill;
    [headView addSubview:self.topImageView];
    
    self.titleLabel = [UILabel labelWithTitle:@"This is a title, this is a title, this is a title" AndColor:@"515151" AndFont:16 AndAlignment:NSTextAlignmentLeft];
    [headView addSubview:self.titleLabel];
    self.titleLabel.numberOfLines = 1;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.topImageView.mas_bottom).offset(15);
        make.left.equalTo(headView.mas_left).offset(15);
        make.centerX.equalTo(headView.mas_centerX);
        make.bottom.equalTo(headView.mas_bottom).offset(-70);
    }];
    
    //价格
    self.priceLabel = [UILabel labelWithTitle:@"Price: $1000.00" AndColor:@"8a8a8a" AndFont:15 AndAlignment:NSTextAlignmentLeft];
    [headView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.titleLabel.mas_left);
    }];
    
    
    return headView;
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
