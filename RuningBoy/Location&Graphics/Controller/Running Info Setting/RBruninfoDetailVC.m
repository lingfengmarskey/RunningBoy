//
//  RBruninfoDetailVC.m
//  RuningBoy
//
//  Created by marskey on 16/3/26.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBruninfoDetailVC.h"
#import "RBruninfoSettingModel.h"
NSString *const DefaultString = @"默认";
@interface RBruninfoDetailVC ()<UIPickerViewDataSource, UIPickerViewDelegate>
// 显示lable
@property (nonatomic, retain) UILabel *showLable;
// 信息介绍
@property (nonatomic, retain) UILabel *infoLable;
// 选项
@property (nonatomic, retain) UIPickerView *selectedPickerView;
// dataArr
@property (nonatomic, retain) NSArray *dataArr;
// infoModel
@property (nonatomic, retain) RBruninfoSettingModel *currentModel;
// integer
@property (nonatomic, copy) NSString *dataInteger;
// decimal
@property (nonatomic, copy) NSString *dataDecimal;
// British Model
@property (nonatomic, retain) RBruninfoSettingModel *britishModel;

@end

@implementation RBruninfoDetailVC

// 显示lable
- (UILabel *)showLable{
    if (!_showLable) {
        _showLable = [[UILabel alloc]init];
        _showLable.text = DefaultString;
        _showLable.textAlignment = NSTextAlignmentCenter;
        _showLable.font = [UIFont fontWithName:@"Helvetica" size:[Tools autoSuitFontSize:51 DesignDevice:iPhone4]];
        [self.view addSubview:_showLable];
        [_showLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(64);
            make.right.left.offset(0);
            make.height.mas_equalTo([Tools autoSuitHeight:135 DesignDevice:iPhone4]);
        }];
    }
    return _showLable;
}
// 说明lable
- (UILabel *)infoLable{
    if (!_infoLable) {
        _infoLable = [[UILabel alloc]init];
        _infoLable.text = DefaultString;
        _infoLable.textAlignment = NSTextAlignmentCenter;
        _infoLable.backgroundColor = [UIColor whiteColor];
        _infoLable.font = [UIFont systemFontOfSize:[Tools autoSuitFontSize:17 DesignDevice:iPhone4]];
        [self.view addSubview:_infoLable];
        __weak typeof(self) WeakSelf = self;
        [_infoLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(WeakSelf.showLable.mas_bottom).with.offset(0);
            make.right.left.offset(0);
            make.height.mas_equalTo([Tools autoSuitHeight:60 DesignDevice:iPhone4]);
        }];
    }
    return _infoLable;
}

// 选择器
- (UIPickerView *)selectedPickerView{
    if (!_selectedPickerView) {
        _selectedPickerView = [UIPickerView new];
        _selectedPickerView.delegate = self;
        _selectedPickerView.dataSource = self;
        [self.view addSubview:_selectedPickerView];
        __weak typeof(self) WeakSelf = self;
        [_selectedPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(WeakSelf.infoLable.mas_bottom).with.offset(2);
            make.left.right.bottom.offset(0);
        }];
    }
    return _selectedPickerView;
}
// 数据数组
- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [RBruninfoSettingModel getRunInfoSettingModels];
    }
    return _dataArr;
}
// 当前数据中间变量
- (RBruninfoSettingModel *)currentModel{
    if (!_currentModel) {
        _currentModel = [RBruninfoSettingModel new];
        _currentModel = self.dataArr[self.selectedRowNum];
    }
    return _currentModel;
}
// BritishModel
- (RBruninfoSettingModel *)britishModel{
    if (!_britishModel) {
        _britishModel = [RBruninfoSettingModel new];
        _britishModel = [RBruninfoSettingModel getRunInfoSettingBritishModels][self.selectedRowNum];
    }
    return _britishModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    RBruninfoSettingModel *model = self.dataArr[self.selectedRowNum];
    self.view.backgroundColor = Mlf_Color(248, 248, 248);
    self.infoLable.text = [NSString stringWithFormat:@"请选择%@,以便更精确的计算距离", model.runSettingTitle];
    self.showLable.backgroundColor = Mlf_Color(248, 248, 248);
    self.selectedPickerView.backgroundColor = [UIColor whiteColor];
    
}
- (void)setup{
    UIBarButtonItem *backbtn = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(backLastpage)];
    self.navigationItem.leftBarButtonItem = backbtn;
}
#pragma mark - back last action
- (void)backLastpage{
    __weak typeof(self) weakSelf = self;
    self.saveBlock(weakSelf.showLable.text, weakSelf.selectedRowNum);
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - pickerview  datasource method
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *content;
    if (![self.unitString isEqualToString:@"英制"]) {
        NSArray *temp = self.currentModel.componnetArr[component];
        content = temp[row];
    }else{
        NSArray *temp = self.britishModel.componnetArr[component];
        content = temp[row];
    }
    return content;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.currentModel.componnetArr.count;
}
// 滚动数据来源
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *temp = self.currentModel.componnetArr[component];
    // 英制下的数据
    if ([self.unitString isEqualToString:@"英制"]) {
        NSArray *arr = self.britishModel.componnetArr[component];
        return arr.count;
    }
    // 公制下的数据
    return temp.count;
}

#pragma mark - pickerview delegate method
// 关联显示台数据
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *content;
    if (![self.unitString isEqualToString:@"英制"]) {
        NSArray *temp = self.currentModel.componnetArr[component];
        content = temp[row];
    }else{
        NSArray *temp = self.britishModel.componnetArr[component];
        content = temp[row];
    }
    // 获取整数位&小数位
    if (!component) {
        self.dataInteger = content;
    }else{
        self.dataDecimal = content;
    }
    
    if (self.currentModel.componnetArr.count > 1)
        // 身高&体重
    {
        if (self.selectedRowNum == 1) {
        // 身高
            if (![self.unitString isEqualToString:@"英制"])
            {
            // 1.默认公制
            self.showLable.text = [NSString stringWithFormat:@"%@.%@厘米",self.dataInteger ? self.dataInteger : @"0", self.dataDecimal ? self.dataDecimal : @"0"];
            }
            else
            {
            // 2.英制
            self.showLable.text = [NSString stringWithFormat:@"%@.%@英尺",self.dataInteger ? self.dataInteger : @"0", self.dataDecimal ? self.dataDecimal : @"0"];
                
            }
        }else{
        // 体重
            if (![self.unitString isEqualToString:@"英制"])
            {
                // 1.默认公制
                self.showLable.text = [NSString stringWithFormat:@"%@.%@千克",self.dataInteger ? self.dataInteger : @"0", self.dataDecimal ? self.dataDecimal : @"0"];
            }
            else
            {
                // 2.英制
                self.showLable.text = [NSString stringWithFormat:@"%@.%@磅",self.dataInteger ? self.dataInteger : @"0", self.dataDecimal ? self.dataDecimal : @"0"];
            }
        }
    }
    else
    {   // 性别 单位
        self.showLable.text = content;
    }
}
#pragma mark - data save in net



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
