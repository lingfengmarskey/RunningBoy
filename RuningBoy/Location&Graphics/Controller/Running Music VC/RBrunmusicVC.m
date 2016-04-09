//
//  RBrunmusicVC.m
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunmusicVC.h"
#import "RBrunmusicPlistCell.h"
#import "RBrunmusicDetailVC.h"
@interface RBrunmusicVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *modelMusicArr;

@end
static NSString *reuseidentifermusiclistcell = @"reuseidentifermusiclistcell";
@implementation RBrunmusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self creatTableView];
    [self netWork];
}
- (void)setup{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"音乐列表";
}
- (void)netWork{
    
    
}
- (NSArray *)modelMusicArr{
    if (!_modelMusicArr) {
        _modelMusicArr = [NSArray array];
        _modelMusicArr = @[@"",@"",@"",@"",@""];
    }
    return _modelMusicArr;
}
- (void)creatTableView{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = MLF_Height(100, iPhone4);
    [self.view addSubview:self.tableView];
}
#pragma mark - tableview delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelMusicArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RBrunmusicPlistCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseidentifermusiclistcell];
    if (!cell) {
        cell = [[RBrunmusicPlistCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseidentifermusiclistcell];
    }
    cell.bgImageView.image = [UIImage imageNamed:@"iconfont-bad"];
    cell.musicTitleLable.text = @"音乐列表测试";
    return cell;
}


/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 return 0;
 }
 */

#pragma mark - To music detail VC
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RBrunmusicDetailVC *musicdetailVC = [RBrunmusicDetailVC new];
    [self.navigationController pushViewController:musicdetailVC animated:YES];
 
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
