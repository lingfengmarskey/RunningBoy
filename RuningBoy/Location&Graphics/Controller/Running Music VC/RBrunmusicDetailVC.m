//
//  RBrunmusicDetailVC.m
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunmusicDetailVC.h"
#import "RBrunmusicPlistDetailCell.h"
#import "RBrunmusicPlistDetailHeaderView.h"
@interface RBrunmusicDetailVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *modellistArr;

@end
static NSString *reuseidentifiermusicplistdetailcell = @"reuseidentifiermusicplistdetailcell";
static NSString *reuseidentifiermusicplistdetailheaderView = @"reuseidentifiermusicplistdetailheaderView";
static NSString *reuseidentifiermusicplistdefaultcell = @"reuseidentifiermusicplistdefaultcell";
@implementation RBrunmusicDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self creatTableView];
    [self netWork];
}
- (void)setup{
    self.navigationItem.title = @"音乐列表详情";
    
}
- (void)netWork{
    
    
}
- (NSArray *)modellistArr{
    if (!_modellistArr) {
        _modellistArr = [NSArray array];
        _modellistArr = @[@"",@"",@"",@"",@"",@""];
    }
    return _modellistArr;
}
- (void)creatTableView{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = 0;

    [self.tableView registerClass:[RBrunmusicPlistDetailHeaderView class] forHeaderFooterViewReuseIdentifier:reuseidentifiermusicplistdetailheaderView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseidentifiermusicplistdefaultcell];
    [self.view addSubview:self.tableView];
}
#pragma mark - tableview delegate method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.modellistArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RBrunmusicPlistDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseidentifiermusicplistdetailcell];
    if (!cell) {
        cell = [[RBrunmusicPlistDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseidentifiermusicplistdetailcell ];
    }
    UITableViewCell *defaultcell = [tableView dequeueReusableCellWithIdentifier:reuseidentifiermusicplistdefaultcell];
    
    if (!defaultcell) {
        defaultcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseidentifiermusicplistdefaultcell];
    }
    defaultcell.textLabel.font = [UIFont systemFontOfSize:MLF_Width(17, iPhone4)];
    
    if (indexPath.row == 0) {
        defaultcell.textLabel.text = @"列表详细介绍****************************************";
        defaultcell.textLabel.numberOfLines = 0;
        return defaultcell;
    }else if (indexPath.row == 1){
        defaultcell.textLabel.text = @"顺序播放";
        return defaultcell;
    }else{
        NSLog(@" cus cell");
    return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return MLF_Height(68, iPhone4);
    }else if (indexPath.row == 1){
        return MLF_Height(33, iPhone4);
    }else{
        return MLF_Height(53, iPhone4);
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 1;
 
 }
// header view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RBrunmusicPlistDetailHeaderView *headerView = [[RBrunmusicPlistDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, MLF_Height(161, iPhone4))];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return MLF_Height(161, iPhone4);

}

#pragma mark - selected method
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSLog(@"click section :%d \nrow :%d", indexPath.section, indexPath.row);
     
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
