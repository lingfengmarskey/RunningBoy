//
//  RBLocationGraphicsVeiwController.m
//  RuningBoy
//
//  Created by marskey on 16/3/23.
//  Copyright © 2016年 marskey. All rights reserved.

#import "RBLocGraphDataShowPlateView.h"
#import "RBLocationGraphicsVeiwController.h"
#import "RBMusicPlayerView.h"
#import "RBruninfoSettingVC.h"
#import "RBrunprepareVC.h"
#import "RBrunactivitiesVC.h"
#import "RBrunmusicVC.h"
#import "Route.h"
#define NETPOST @"http://music.163.com/eapi/v3/playlist/detail/"
@interface RBLocationGraphicsVeiwController ()<CLLocationManagerDelegate, MKMapViewDelegate>
// 底部按钮
@property (nonatomic, retain)UIButton *runBottomBtn;
// 数据显示台
@property (nonatomic, retain) RBLocGraphDataShowPlateView *plateView;
// 功能显示区
@property (nonatomic, retain) UIScrollView *locAndPlayerScrollView;
// LocationManager
@property (nonatomic, retain) CLLocationManager *locationManager;
// mapView
@property (nonatomic, retain) MKMapView *mapView;
// musicplayer
@property (nonatomic, retain) RBMusicPlayerView *musicPlayerView;
// save state string
@property (nonatomic, copy) NSString *saveState;
// coreDataManager
@property (nonatomic, retain) RBCoreDataTool *coreDataManager;

@end

@implementation RBLocationGraphicsVeiwController
- (RBCoreDataTool *)coreDataManager{
    if (!_coreDataManager) {
        _coreDataManager = [RBCoreDataTool defaultCoreDataManager];
    }
    return _coreDataManager;
}

// 底部按钮给尺寸
- (UIButton *)runBottomBtn
{
    if (!_runBottomBtn) {
        _runBottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _runBottomBtn.bounds = CGRectMake(0, 0, WIDTH, 49);
        [_runBottomBtn addTarget:self action:@selector(toRunsetting) forControlEvents:UIControlEventTouchUpInside];
    }
    return _runBottomBtn;
}

// 功能现实台
- (UIScrollView *)locAndPlayerScrollView
{
    if (!_locAndPlayerScrollView) {
        _locAndPlayerScrollView = [[UIScrollView alloc]init];
        _locAndPlayerScrollView.scrollEnabled = YES;
        _locAndPlayerScrollView.pagingEnabled = YES;
        _locAndPlayerScrollView.bounces = NO;
        [self.view addSubview:_locAndPlayerScrollView];
        __weak typeof(self)WeakSelf = self;
        [_locAndPlayerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(WeakSelf.plateView.stepCountLable.mas_bottom).with.mas_offset(0);
            make.left.right.mas_offset(0);
//            make.height.mas_equalTo(MLF_Height(138, iPhone4));
            make.bottom.offset(-49);
        }];
    }
    return _locAndPlayerScrollView;
}

// 定位
- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locationManager setDistanceFilter:kCLDistanceFilterNone];
    }
    return _locationManager;
}

// 数据展示台
- (RBLocGraphDataShowPlateView *)plateView
{
    if (!_plateView) {
        _plateView = [[RBLocGraphDataShowPlateView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, MLF_Height(200, iPhone4))];
        _plateView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:_plateView];
    }
    return _plateView;
    
}
// 地图
- (MKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [MKMapView new];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        _mapView.scrollEnabled = NO;
        _mapView.mapType = MKMapTypeStandard;
        [self.locAndPlayerScrollView addSubview:_mapView];
        __weak typeof(self)WeakSelf = self;
        [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(WeakSelf.locAndPlayerScrollView);
            make.width.mas_equalTo(WIDTH);
            make.height.mas_equalTo(WeakSelf.locAndPlayerScrollView);
        }];
    }
    return _mapView;
}

// musicplayer View
- (RBMusicPlayerView *)musicPlayerView
{
    if (!_musicPlayerView) {
        _musicPlayerView = [[RBMusicPlayerView alloc]init];
        [self.locAndPlayerScrollView addSubview:_musicPlayerView];
        __weak typeof(self)WeakSelf = self;
        [_musicPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(WeakSelf.locAndPlayerScrollView);
            make.left.mas_equalTo(WeakSelf.mapView.mas_right);
            make.width.mas_equalTo(WIDTH);
            make.height.mas_equalTo(WeakSelf.locAndPlayerScrollView);
        }];
    }
    return _musicPlayerView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    // add Observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runinfoSettingState:) name:@"RunInfoSettingStateString" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.plateView.backgroundColor = [UIColor whiteColor];
    self.locAndPlayerScrollView.backgroundColor = [UIColor whiteColor];
    
    // location fuction
    [self locationFuction];
    
    // 地图
    self.mapView.backgroundColor = COLOR;
    // music player view
    UITapGestureRecognizer *tapMusicPlist = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toMusicPlist)];
    [self.musicPlayerView.musicLlistImageView addGestureRecognizer:tapMusicPlist];
    

  
}
- (void)viewWillAppear:(BOOL)animated{
    // 数据显示台数据更新,展示
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Route" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"search in coreData no result");
    }else{
        NSLog(@"search seccess in coreData");
        NSInteger totalmetrs = 0;
        NSInteger totalTime = 0;
        for (int i = 0; i < fetchedObjects.count; i++) {
            Route *model = fetchedObjects[i];
            totalmetrs += model.totalDistances.integerValue;
            totalTime += [self timeFromString:model.totalTime];
        }
        self.plateView.locGraphTotalkmLable.text = [NSString stringWithFormat:@"%.2f", totalmetrs / 1000.0];
        self.plateView.locGraphStepNumLable.text = [NSString stringWithFormat:@"%ld", totalmetrs * 100 / 40];
        self.plateView.locGraphTempoLable.text = [self timestringFromTiem:totalTime];
        CGFloat calorie = totalmetrs * 80 * totalTime * 0.4;
        if (calorie < 1000) {
            self.plateView.locGraphCalorieLable.text = [NSString stringWithFormat:@"%.1f cal", calorie];
        }else{
            self.plateView.locGraphCalorieLable.text = [NSString stringWithFormat:@"%.1f Kcal", calorie / 1000.0];
        }
    }
    
}
- (NSString *)timestringFromTiem:(NSInteger)second{
    NSInteger h = second / 3600;
    NSInteger min = second / 60;
    NSInteger sec = second % 60;
    if (!h) {
        if (min) {
            return [NSString stringWithFormat:@"%ldm:%lds", (long)min, (long)sec];
        }else{
            return [NSString stringWithFormat:@"%lds", (long)sec];
        }
    }else{
        if (min) {
            return [NSString stringWithFormat:@"%ldh:%ldm:%lds", (long)h, (long)min, (long)sec];
        }else{
            return [NSString stringWithFormat:@"%ldh:00m:%lds", (long)h, (long)sec];
        }
    }
}
- (NSInteger)timeFromString:(NSString *)string{
    NSArray *strs = [string componentsSeparatedByString:@":"];
    NSString *den = strs.firstObject;
    NSString *dec = strs.lastObject;
    return den.intValue * 60 + dec.intValue;
}
// nav setup
- (void)setup
{
    // 历史活动按钮
    UIButton *temp = [UIButton buttonWithType:UIButtonTypeCustom];
    temp.bounds = CGRectMake(0, 0, 40, 40);
    [temp setImage:[UIImage imageNamed:@"iconfont-run"] forState:UIControlStateNormal];
    temp.contentMode = UIViewContentModeScaleAspectFit;
    [temp addTarget:self action:@selector(toActivities) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *actBtn = [[UIBarButtonItem alloc] initWithCustomView:temp];
    // 基本跑步信息设置按钮
    UIButton *insetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    insetBtn.bounds = CGRectMake(0, 0, 30, 30);
    [insetBtn setImage:[UIImage imageNamed:@"iconfont-set"] forState:UIControlStateNormal];
    [insetBtn addTarget:self action:@selector(toRunsetting) forControlEvents:UIControlEventTouchUpInside];
    insetBtn.contentMode = UIViewContentModeScaleAspectFit;
    UIBarButtonItem *hisBtn = [[UIBarButtonItem alloc] initWithCustomView:insetBtn];
    self.navigationItem.leftBarButtonItem = actBtn;
    self.navigationItem.rightBarButtonItem = hisBtn;
    self.navigationItem.rightBarButtonItem.customView.alpha = 1;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - RunInfoSettingState Observer Method

- (void)runinfoSettingState:(NSNotification *)sender
{
    NSLog(@"%@", sender.userInfo);
    if (sender.userInfo) {
        self.saveState = [sender.userInfo objectForKey:@"savestate"];
    }
}


#pragma mark - To Activity VC
- (void)toActivities
{
    RBrunactivitiesVC *actVC = [RBrunactivitiesVC new];
    [self.navigationController pushViewController:actVC animated:YES];
    
}

#pragma mark - To run setting OR runprepare VC method
- (void)toRunsetting
{
    if (!self.saveState) {
        RBruninfoSettingVC *runSettingVC = [[RBruninfoSettingVC alloc] init];
        [self.navigationController pushViewController:runSettingVC animated:YES];
    }else{
        RBrunprepareVC *prepareVC = [RBrunprepareVC new];
        [self.navigationController pushViewController:prepareVC animated:YES];
    }
}

#pragma mark - To music plist VC
- (void)toMusicPlist
{
    RBrunmusicVC *musicVC = [RBrunmusicVC new];
    [self.navigationController pushViewController:musicVC animated:YES];
}

#pragma mark - location fuction method
- (void)locationFuction
{
    [RBlocationService beginLocation:self.locationManager inViewController:self];
}


#pragma mark - Location Delegate Method
// 开始定位
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *loc = locations.lastObject;
    [manager stopUpdatingLocation]; 
    NSLog(@"当前经度:%f, 当前纬度:%f", loc.coordinate.longitude, loc.coordinate.latitude);
    
    
}


#pragma mark - MapView Delegate Method
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    // 显示区域经纬度范围
    MKCoordinateSpan span = MKCoordinateSpanMake(0.031109, 0.024153);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [self.mapView setRegion:region animated:YES];
    NSLog(@"map loc longitude :%f", userLocation.coordinate.longitude);
    
}

// 隐藏/显示TabBar
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.view.tag) {
        self.view.tag = 0;
        // 底部按钮隐藏
        [UIView animateWithDuration:0.4 animations:^{
            CGRect rect = self.runBottomBtn.frame;
            rect.origin.y = HEIGHT;
            self.runBottomBtn.frame = rect;
        } completion:^(BOOL finished) {
        // TabBar显示
            [self hidenTabBar:self.tabBarController.tabBar Autorevers:YES];
            self.navigationItem.rightBarButtonItem.customView.alpha = 0;
        }];
    }else{
        // TabBar 隐藏
        [self hidenTabBar:self.tabBarController.tabBar Autorevers:NO];
        self.navigationItem.rightBarButtonItem.customView.alpha = 1;
        // 底部按钮显示
        [self showRunBottomBtn];
        self.view.tag = 1;
    }
}

// 显示隐藏tabbar method
- (void)hidenTabBar:(UIView *)tabBar Autorevers:(BOOL)isrevers
{
    CABasicAnimation *hideAni = [CABasicAnimation animationWithKeyPath:@"position.y"];
    NSNumber *value = [NSNumber numberWithFloat:tabBar.frame.origin.y + 25];
    NSNumber *anotherValue = [NSNumber numberWithFloat:HEIGHT + 25];
    hideAni.fromValue = isrevers ? anotherValue : value;
    hideAni.toValue = isrevers ? value : anotherValue;
    hideAni.duration = 0.4;
    hideAni.removedOnCompletion = NO;
    hideAni.fillMode = kCAFillModeForwards;
    hideAni.repeatCount = 0;
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    NSNumber *opaval = @1;
    NSNumber *anoOpaval = @0;
    opacity.fromValue = isrevers ? anoOpaval : opaval;
    opacity.toValue = isrevers ? opaval : anoOpaval;
    opacity.duration = 0.4;
    opacity.removedOnCompletion = NO;
    opacity.fillMode = kCAFillModeForwards;
    opacity.repeatCount = 0;
    
    [tabBar.layer addAnimation:opacity forKey:@"opa"];
    [tabBar.layer addAnimation:hideAni forKey:@"tabbarhiden"];
    if (!isrevers) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self makeTabBarHidden:YES];
        });
    }else{
        [self makeTabBarHidden:NO];
    }
}
// 显示底部按钮
- (void)showRunBottomBtn
{
    CGRect rect = self.runBottomBtn.bounds;
    rect.origin.y = HEIGHT;
    self.runBottomBtn.frame = rect;
    self.runBottomBtn.backgroundColor = [UIColor redColor];
    [self.runBottomBtn setTitle:@"开始跑步" forState:UIControlStateNormal];
    [self.view addSubview:self.runBottomBtn];
    [UIView animateWithDuration:0.4 animations:^{
        CGRect temp = self.runBottomBtn.frame;
        temp.origin.y = HEIGHT - 49;
        self.runBottomBtn.frame = temp;
    }];
}

// TabBarHide&Failure!!!
- (void)makeTabBarHidden:(BOOL)hide
{
    if ( [self.tabBarController.view.subviews count] < 2 )
    {
        return;
    }
    UIView *contentView;
    
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    }
    else
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    //    [UIView beginAnimations:@"TabbarHide" context:nil];
    if ( hide )
    {
        contentView.frame = self.tabBarController.view.bounds;
    }
    else
    {
        contentView.frame = CGRectMake(self.tabBarController.view.bounds.origin.x,
                                       self.tabBarController.view.bounds.origin.y,
                                       self.tabBarController.view.bounds.size.width,
                                       self.tabBarController.view.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    }
    self.tabBarController.tabBar.hidden = hide;
    //    [UIView commitAnimations];
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
