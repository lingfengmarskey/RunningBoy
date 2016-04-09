//
//  RBrunactivitiesVC.m
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunactivitiesVC.h"
#import "RBrunactivityListCell.h"
#import "RBrunActiListHeaderView.h"
#import "RBrunDetailDataVC.h"
#import "Entity.h"
#import "Velocity.h"
#import "Route.h"
@interface RBrunactivitiesVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, retain) RBrunActiListHeaderView *headerView;
@property (nonatomic, retain) RBCoreDataTool *coredataManager;

@end
static NSString *reuseidentiferrunlistheaderview = @"reuseidentiferrunlistheaderview";
@implementation RBrunactivitiesVC
- (RBCoreDataTool *)coredataManager{
    if (!_coredataManager) {
        _coredataManager = [RBCoreDataTool defaultCoreDataManager];
    }
    return _coredataManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self creatTableView];
    [self dataWork];
}
- (void)setup{
    self.view.backgroundColor = Mlf_Color(248, 248, 248);
    self.navigationItem.title = @"历史记录";
}
- (void)dataWork
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Route" inManagedObjectContext:self.coredataManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coredataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil)
    {
        NSLog(@"no result");
    }
    else
    {
        for (Route *temp in fetchedObjects) {
            [self.modelArr addObject:temp];
        }
    }
    [self.tableView reloadData];
}

- (NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}
- (void)creatTableView{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = MLF_Height(92, iPhone4);
    self.tableView.sectionFooterHeight = 0;

    [self.tableView registerClass:[RBrunActiListHeaderView class] forHeaderFooterViewReuseIdentifier:reuseidentiferrunlistheaderview];
    [self.view addSubview:self.tableView];
}
// headerview
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RBrunActiListHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseidentiferrunlistheaderview];
        return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return MLF_Height(21, iPhone4);
}

#pragma mark - tableview delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseidentifierrunactivitylistcell = @"reuseidentifierrunactivitylistcell";
    RBrunactivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseidentifierrunactivitylistcell];
    if (!cell)
    {
        cell = [[RBrunactivityListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseidentifierrunactivitylistcell];
    }
    Route *model = self.modelArr[indexPath.row];
    cell.model = model;
    return cell;
}

 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 1;
 }

#pragma mark - To detail data VC
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     RBrunactivityListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
     RBrunDetailDataVC *detailVC = [RBrunDetailDataVC new];
     detailVC.currentDate = cell.model.beginDate;
     [self.navigationController pushViewController:detailVC animated:YES];
     
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
