//
//  RBruninfoSettingVC.m
//  
//
//  Created by marskey on 16/3/26.
//
//

#import "RBruninfoSettingVC.h"
#import "RBruninfoDetailVC.h"
#import "RBLocationGraphicsVeiwController.h"
@interface RBruninfoSettingVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *modelArr;
@property (nonatomic, retain) UILabel *infomationLable;
@property (nonatomic, retain) UIButton *saveSettingBtn;
@property (nonatomic, retain) NSArray *listArr;

@property (nonatomic, retain) RBruninfoDetailVC *detailVC;

@end

@implementation RBruninfoSettingVC
// 获取信息的相关说明
- (UILabel *)infomationLable{
    if (!_infomationLable) {
        _infomationLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
        _infomationLable.numberOfLines = 0;
        _infomationLable.text = @"\t     我们需要获取您的以上信息,来更准确的计算您消耗的卡路里等相关信息.\n\t     如果您不提供相关信息,我们将按照默认值进行相关计算";
        _infomationLable.font = [UIFont systemFontOfSize:[Tools autoSuitFontSize:17 DesignDevice:iPhone4]];
    }
    return _infomationLable;
}
// 保存按钮
- (UIButton *)saveSettingBtn{
    if (!_saveSettingBtn) {
        _saveSettingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveSettingBtn.backgroundColor = [UIColor grayColor];
        [_saveSettingBtn setTitle:@"保存" forState:UIControlStateNormal];
        _saveSettingBtn.frame = CGRectMake(0, HEIGHT - 49, WIDTH, 49);
        [self.view addSubview:_saveSettingBtn];
    }
    return _saveSettingBtn;
}
- (NSArray *)listArr{
    if (!_listArr) {
        _listArr = @[@"默认 >>", @"可选 >>", @"可选 >>", @"未设定 >>"];
    }
    return _listArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self creatTableView];
    [self netWork];
}
- (void)setup{
    self.navigationController.title = @"基本设置";
}
- (void)netWork{
    
    
}
- (NSArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSArray array];
        _modelArr = @[@"测量单位", @"身高", @"体重", @"性别"];
    }
    return _modelArr;
}
- (void)creatTableView{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.rowHeight = [Tools autoSuitHeight:50 DesignDevice:iPhone4];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

#pragma mark - add save btn action
    [self.saveSettingBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - save Btn action
- (void)saveAction:(UIButton *)sender{
    BOOL result = YES;
    for (int i = 0; i < 4; i++) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        // 是否全部选择
        if ([cell.detailTextLabel.text containsString:@">"]) {
            result = NO;
        }
    }
    if (result) {
        if (sender.tag) {
            sender.tag = 0;
            [sender setTitle:@"保存" forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor grayColor];
        }
        else{
            sender.tag = 1;
            [sender setTitle:@"已保存" forState:UIControlStateNormal];
            sender.backgroundColor = [UIColor redColor];
            for (int i = 0; i < 4; i++) {
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                NSLog(@"cell.text%@", cell.detailTextLabel.text);
            }
            // 发送已保存的info
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RunInfoSettingStateString" object:nil userInfo:@{@"savestate" : @"saved"}];
        }
    }else{
        // 保存默认值
  
    }
}

#pragma mark - tableview deletage method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseidentiferrunsettingcell = @"reuseidentiferrunsettingcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseidentiferrunsettingcell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseidentiferrunsettingcell];
    }
    cell.textLabel.text = self.modelArr[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:[Tools autoSuitFontSize:18 DesignDevice:iPhone4]];
    cell.detailTextLabel.text = @"默认 >>";
    return cell;
}


#pragma mark - cell infomaiton 
// 说明头视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.infomationLable;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    UIFont *temp = [UIFont systemFontOfSize:[Tools autoSuitFontSize:17 DesignDevice:iPhone4]];
    return [Tools getSuitableHeightOfLableContentString:self.infomationLable.text OringeWidth:WIDTH Font:temp];
}

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
 */
#pragma mark - To Detail Setting VC & Show Selected Result
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RBruninfoDetailVC *detailVC = [[RBruninfoDetailVC alloc] init];
    UITableViewCell *unitCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    detailVC.unitString = unitCell.detailTextLabel.text;
    detailVC.selectedRowNum = indexPath.row;
    // 选择之后的回调
    detailVC.saveBlock = ^(NSString *str, NSInteger num)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:num inSection:0]];
        // 单位reverse
        if (num == 0)
        {
            UITableViewCell *statureCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            UITableViewCell *weightCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            if (![str isEqualToString:unitCell.detailTextLabel.text] )
            {
                // 选中的单位与原来的不同 并且原来已经选择过单位
                NSUInteger index = statureCell.detailTextLabel.text.length - 2;
                NSString *tempstr = [statureCell.detailTextLabel.text substringToIndex:index];
                if ([statureCell.detailTextLabel.text containsString:@"厘米"])
                {
                    statureCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f英尺", [Tools inputValue:[tempstr floatValue] CurrentUnit:UnitCM]];
                }
                else if ([statureCell.detailTextLabel.text containsString:@"英尺"])
                {
                    statureCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f厘米", [Tools inputValue:[tempstr floatValue] CurrentUnit:UnitFoot]];
                }
                if ([weightCell.detailTextLabel.text containsString:@"千克"]) {
                    weightCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f磅", [Tools inputValue:[tempstr floatValue] CurrentUnit:UnitKg]];
                }
                else if ([weightCell.detailTextLabel.text containsString:@"磅"])
                {
                    weightCell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f千克", [Tools inputValue:[tempstr floatValue] CurrentUnit:UnitPound]];
                }
            }
            
        }
    
        cell.detailTextLabel.text = str;
    };
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
