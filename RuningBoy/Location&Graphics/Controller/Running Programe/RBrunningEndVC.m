//
//  RBrunningEndVC.m
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunningEndVC.h"
#import "RBrunTemporunExcelView.h"
#import "RBrunendShareView.h"
#import "Route.h"
@interface RBrunningEndVC ()<UITextFieldDelegate>
// 配速表
@property (nonatomic, retain) RBrunTemporunExcelView *temporunView;
// 分享视图
@property (nonatomic, retain) RBrunendShareView *shareView;
// bgscrollView
@property (nonatomic, retain) UIScrollView *bgScrollView;

@property (nonatomic, retain) RBCoreDataTool *coredataManager;

@property (nonatomic, copy) NSString *runState;
@end

@implementation RBrunningEndVC
// 配速图
- (RBrunTemporunExcelView *)temporunView{
    if (!_temporunView) {
        _temporunView = [[RBrunTemporunExcelView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, MLF_Height(295, iPhone4)) BeginDate:self.beginDate];
        _temporunView.backgroundColor = [UIColor brownColor];
    }
    return _temporunView;
}
// 分享
- (RBrunendShareView *)shareView{
    if (!_shareView) {
        _shareView = [[RBrunendShareView alloc] initWithFrame:CGRectMake(0, self.temporunView.h, WIDTH, MLF_Height(185, iPhone4))];
        [_shareView.smillBtn addTarget:self action:@selector(stateAction:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView.normalBtn addTarget:self action:@selector(stateAction:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView.badBtn addTarget:self action:@selector(stateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareView;
}
// bgscrollview
- (UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, WIDTH, HEIGHT + 20)];
        _bgScrollView.contentSize = CGSizeMake(0, HEIGHT * 1.5);
        _bgScrollView.bounces = NO;
        _bgScrollView.scrollEnabled = NO;
        [self.view addSubview:_bgScrollView];
    }
    return _bgScrollView;
}
- (RBCoreDataTool *)coredataManager{
    if (!_coredataManager) {
        _coredataManager = [RBCoreDataTool defaultCoreDataManager];
    }
    return _coredataManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self creatUI];
}

- (void)setup{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    

    self.view.backgroundColor = [UIColor whiteColor];
    self.bgScrollView.backgroundColor = Mlf_Color(248, 248, 248);
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.shareView.shareTextField.delegate = nil;
}
- (void)creatUI{
// 分享视图
    [self.bgScrollView addSubview:self.shareView];
// 配速表
    [self.bgScrollView addSubview:self.temporunView];
    
    self.shareView.shareTextField.delegate = self;
    
// submit target action
    [self.shareView.submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self dataResolve];
}

- (void)dataResolve{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Route" inManagedObjectContext:self.coredataManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"beginDate = %@", self.beginDate];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coredataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"fetchObjects no result");
    }else{
        Route *model = fetchedObjects.firstObject;
        NSLog(@"=+++++velocity count :%d", model.velocity.count);
        CGFloat distance = 0;
        if (model.totalDistances.floatValue > 1000) {
            distance = model.totalDistances.floatValue / 1000.0;
        }else{
            distance = model.totalDistances.floatValue;
        }
        self.temporunView.totalDistance.text = [NSString stringWithFormat:@"距离:%.2f公里", distance];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        self.temporunView.topTimeLable.text = [formatter stringFromDate:self.beginDate];
        self.temporunView.timeLable.text = model.totalTime;
        self.temporunView.tempoLable.text = [NSString stringWithFormat:@"%.1f m/s", model.averageVelocity.floatValue];
        self.temporunView.calorieLable.text = [NSString stringWithFormat:@"%.1fcal", model.totalDistances.floatValue * 200];
    }
}

- (void)stateAction:(UIButton *)sender
{
    sender.alpha = 0.3;
    UIButton *temp1 = [self.shareView viewWithTag:1];
    UIButton *temp2 = [self.shareView viewWithTag:2];
    UIButton *temp3 = [self.shareView viewWithTag:3];
    if (sender.tag == 1) {
        self.runState = @"good";
        temp2.alpha = 1;
        temp3.alpha = 1;
    }else if (sender.tag == 2){
        self.runState = @"normal";
        temp1.alpha = 1;
        temp3.alpha = 1;
    }else{
        self.runState = @"bad";
        temp1.alpha = 1;
        temp2.alpha = 1;
    }
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    self.bgScrollView.contentOffset = CGPointMake(0, height * 1.0 - 20);
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.bgScrollView.contentOffset = CGPointMake(0, -20);
    
}



#pragma mark - Submit Action
- (void)submitAction
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Route" inManagedObjectContext:self.coredataManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"beginDate = %@", self.beginDate];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coredataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"eftchObjects no result");
    }else{
    Route *model = fetchedObjects.firstObject;
        model.feedBack = self.shareView.shareTextField.text;
        model.runState = self.runState;
    }
    [self.coredataManager saveContext];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.shareView.shareTextField resignFirstResponder];
    return YES;
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
