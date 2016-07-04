//
//  ImgViewController.m
//  BSBDQJTestDemo
//
//  Created by XGJ on 16/5/31.
//  Copyright © 2016年 XGJ. All rights reserved.
//

#import "ImgViewController.h"
#import "IVTableViewCell.h"
#import "VModelClass.h"
#import "VMOperation.h"
#import "Masonry.h"
#import "ViewController.h"
#import "DatasModel.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface ImgViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *number;
    UIRefreshControl *ref;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)VMOperation *reques;

@end

@implementation ImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    number = @"1";
    _array = [NSMutableArray new];
    self.navigationController.navigationItem.title = @"不得姐";
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor blueColor]];
    [customLab setText:@"主菜单"];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = customLab;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self tiaozhuan];
    }];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self xialashuaxin];
    }];
    [self request];
    NSString *str = @"123";
    str = nil;
    if (str.length)
    {
        [self seta];
        
    }
}
-(void)xialashuaxin
{   number = [NSString stringWithFormat:@"%d",(1)];
    __block ImgViewController *VC = self;
    [_array removeAllObjects];
    [_reques setBlockWithReturnBlock:^(id returnValue) {
        for (DatasModel *model in returnValue) {
            [VC.array addObject:model];
        }
        
        [VC.tableView reloadData];
        [VC.tableView.mj_header endRefreshing];

        
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [_reques GetDatas:number];
    
}
-(void)tiaozhuan
{   number = [NSString stringWithFormat:@"%d",([number intValue]+1)];
    __block ImgViewController *VC = self;
    [_reques setBlockWithReturnBlock:^(id returnValue) {
        for (DatasModel *model in returnValue) {
            [VC.array addObject:model];
        }
        [VC.tableView.mj_footer endRefreshing];

        [VC.tableView reloadData];
        
    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [_reques GetDatas:number];

}
-(void)seta{
    NSLog(@"这不是被初始化了吗");
}
-(void)request{
    _reques = [[VMOperation alloc]init];
    __block ImgViewController *VC = self;
    [_reques setBlockWithReturnBlock:^(id returnValue) {
        for (DatasModel *model in returnValue) {
            [VC.array addObject:model];
        }
        [VC.tableView reloadData];
        [VC.tableView.mj_header endRefreshing];

    } WithErrorBlock:^(id errorCode) {
        
    } WithFailureBlock:^{
        
    }];
    [_reques GetDatas:@"1"];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellAccessoryNone;
        
    }
    return _tableView;
}


#pragma mark----------------TableViewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_array count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IVTableViewCell *IVCell = [[IVTableViewCell alloc]init];
    IVCell = [tableView dequeueReusableCellWithIdentifier:@"IVTableViewCell"];
    if (IVCell == nil) {
        IVCell = [[IVTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IVTableViewCell"];
    }
    [IVCell setbaisiqijieDatas:_array[indexPath.row]];
    return IVCell;
}

- (void)reloadCellAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView reloadData];
}

//设置Cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DatasModel *model = _array[indexPath.row];
    return [model cellHeight];
}
/**
 *  跳转
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [_reques push:self data:[_array objectAtIndex:indexPath.row]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
