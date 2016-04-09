//
//  RBrunningBeginVC.m
//  RuningBoy
//
//  Created by marskey on 16/3/27.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunningBeginVC.h"
#import "RBrunbeginView.h"
#import "RBrunningEndVC.h"
#import "RBLocationGraphicsVeiwController.h"
#import "RBCoreDataTool.h"
#import "Entity.h"
#import "Velocity.h"
#import "Route.h"
NSString *const CurrentMusicInfo = @"当前音乐/无音乐";
@interface RBrunningBeginVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>
// time down view
@property (nonatomic, retain) UIView *timeDowncountView;
// timelable
@property (nonatomic, retain) UILabel *timeLable;
// start timer
@property (nonatomic, retain) NSTimer *startTimer;/*------downcountTimer*/
// runbegin view
@property (nonatomic, retain) RBrunbeginView *runbeginView;
// flash nai
@property (nonatomic, retain) CABasicAnimation *flasAni;
// animation images
@property (nonatomic, retain) NSMutableArray *imagesArr;
// progress iamgeview
@property (nonatomic, retain) NSTimer *runTimer;
// captureImages
@property (nonatomic, retain) NSMutableArray *capturedImages;
// overlayView camera user interface
@property (nonatomic, retain) UIView *overlayView;
// imagePickerController
@property (nonatomic, retain) UIImagePickerController *imagePickerController;
// location
@property (nonatomic, retain) CLLocationManager *locationManager;
// locationArr
@property (nonatomic, retain) NSMutableArray *locationRotes;
//  coreDataTool
@property (nonatomic, retain) RBCoreDataTool *coreDataManager;
// currentDate
@property (nonatomic, retain) NSDate *currentDate;
// velocityArr
@property (nonatomic, retain) NSMutableArray *velocitiesArr;
// distancesArr
//@property (nonatomic, retain) NSMutableArray *distancesArr;
// total time
@property (nonatomic, copy) NSString *totaltime;

@end
static NSInteger timecount = 2;
static NSInteger runtime = 0;
@implementation RBrunningBeginVC
// time downcount view
- (UIView *)timeDowncountView{
    if (!_timeDowncountView) {
        _timeDowncountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _timeDowncountView.backgroundColor = [UIColor blackColor];
        UILabel *timeLable = [[UILabel alloc] initWithFrame:_timeDowncountView.bounds];
        timeLable.font = [UIFont systemFontOfSize:[Tools autoSuitFontSize:90 DesignDevice:iPhone4]];
        timeLable.textAlignment = NSTextAlignmentCenter;
        timeLable.textColor = [UIColor whiteColor];
        self.timeLable = timeLable;
        [_timeDowncountView addSubview:timeLable];
        __weak typeof(self) WeakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           WeakSelf.timeLable.text = @"3";
            WeakSelf.startTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timedowncountAction) userInfo:nil repeats:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [WeakSelf.startTimer invalidate];
            });
            [WeakSelf.view addSubview:_timeDowncountView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.3 animations:^{
                    _timeDowncountView.alpha = 0;
                } completion:^(BOOL finished) {
                    [_timeDowncountView removeFromSuperview];
                }];
            });
        });
    }
    return _timeDowncountView;
}
// imagesArr
- (NSArray *)imagesArr{
    if (!_imagesArr) {
        _imagesArr = [NSMutableArray array];
        for (int i = 1; i <= 36; i++) {
            UIImage *temp = [UIImage imageNamed:[NSString stringWithFormat:@"runboy_progress_bottel_%d.tiff", i]];
            [_imagesArr addObject:temp];
        }
    }
    return _imagesArr;
}
// capturedImages
- (NSMutableArray *)capturedImages{
    if (!_capturedImages) {
        _capturedImages = [NSMutableArray array];
    }
    return _capturedImages;
}
// runTimer
- (NSTimer *)runTimer
{
    if (!_runTimer) {
        _runTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runtimeAction) userInfo:nil repeats:YES];
    }
    return _runTimer;
}
// locationManager
- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        // 跑步要求过滤距离为0 精度为导航
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    return _locationManager;
}

// locationRotes
- (NSMutableArray *)locationRotes
{
    if (!_locationRotes) {
        _locationRotes = [NSMutableArray array];
    }
    return _locationRotes;
}

// coreDataManager
- (RBCoreDataTool *)coreDataManager
{
    if (!_coreDataManager) {
        _coreDataManager = [RBCoreDataTool defaultCoreDataManager];
    }
    return _coreDataManager;
}
// velocitiesArr
- (NSMutableArray *)velocitiesArr{
    if (!_velocitiesArr) {
        _velocitiesArr = [NSMutableArray array];
    }
    return _velocitiesArr;
}

//- (NSMutableArray *)distancesArr{
//    if (!_distancesArr) {
//        _distancesArr = [NSMutableArray array];
//    }
//    return _distancesArr;
//}
#pragma mark - RunTimerAction
- (void)runtimeAction
{
    runtime++;
    NSInteger min = runtime / 60;
    NSInteger sec = runtime % 60;
    self.runbeginView.reverseTimeLable.text = [NSString stringWithFormat:@"%02d:%02d", min, sec];
    [self.velocitiesArr addObject:self.runbeginView.sequenceTimeLable.text];
}

// flash animation
- (CABasicAnimation *)flasAni
{
    if (!_flasAni) {
        _flasAni = [CABasicAnimation animation];
        _flasAni.keyPath = @"opacity";
        _flasAni.fromValue = @1;
        _flasAni.toValue = @0.2;
        _flasAni.removedOnCompletion = NO;
        _flasAni.autoreverses = YES;
        _flasAni.repeatCount = MAXFLOAT;
        _flasAni.duration = 1;
        _flasAni.fillMode = kCAFillModeForwards;
    }
    return _flasAni;
}

#pragma mark - Time downcount Action
- (void)timedowncountAction
{
    self.timeLable.text = [NSString stringWithFormat:@"%lu", (long)timecount--];
    CABasicAnimation *posKuro = [CABasicAnimation animationWithKeyPath:@"position.y"];
    posKuro.fromValue = @340;
    posKuro.toValue = @100;
    posKuro.duration = 0.2;
    posKuro.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.timeLable.layer addAnimation:posKuro forKey:@"poskuro"];
    
    CABasicAnimation *opaAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opaAni.fromValue = @1;
    opaAni.toValue = @0;
    opaAni.removedOnCompletion = NO;
    opaAni.fillMode = kCAFillModeForwards;
    opaAni.autoreverses = YES;
    opaAni.repeatCount = 1;
    opaAni.duration = 0.1;
    
    [self.timeLable.layer addAnimation:opaAni forKey:@"opaci"];
    NSLog(@"time start");
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"%s", __FUNCTION__);
    };
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self creatUI];
    
}
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"view will appear");
    runtime = 0;
    timecount = 2;
    self.velocitiesArr = nil;
//    self.distancesArr = nil;
    self.locationRotes = nil;
}
// setup
- (void)setup
{
    self.currentDate = [NSDate date];
    self.navigationController.navigationBarHidden = YES;
}

// UI
- (void)creatUI
{
    // runbeginView
    __weak typeof(self) weakSelf = self;
    self.runbeginView = [[RBrunbeginView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:self.runbeginView];
    
    [self.runbeginView.topLockBtn addTarget:self action:@selector(lockAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.runbeginView.startBtn addTarget:self action:@selector(startRun:) forControlEvents:UIControlEventTouchUpInside];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(unlockAction:)];
    [self.runbeginView addGestureRecognizer:pan];
    
    // stop btn
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(stopRun:)];
    longpress.minimumPressDuration = 3;
    [self.runbeginView.stopBtn addGestureRecognizer:longpress];
    // down
    [self.runbeginView.stopBtn addTarget:self action:@selector(tapStopRun:) forControlEvents:UIControlEventTouchDown];
    // definite time lifted act
    [self.runbeginView.stopBtn addTarget:self action:@selector(tapLiftStopBtn:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchUpInside];
    // photo action
    [self.runbeginView.photoBtn addTarget:self action:@selector(photoAction) forControlEvents:UIControlEventTouchUpInside];
    
    // time downcount view
    [self.view addSubview:self.timeDowncountView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.runTimer fire];
        [self locationService];
    });
    

}

#pragma mark - Lock Action
- (void)lockAction:(UIButton *)sender
{
        // 执行锁屏
        sender.tag = 1;
        [UIView animateWithDuration:0.2 animations:^{
        self.runbeginView.topLockBtn.alpha = 0;
        self.runbeginView.unlockLable.alpha = 1;
        self.runbeginView.startBtn.alpha = 0;
        self.runbeginView.stopBtn.alpha = 0;
        self.runbeginView.currentLable.text = @">>>>>>>>>>>>>>>>>";
        self.runbeginView.lastSongBtn.alpha = 0;
        self.runbeginView.nextSontBtn.alpha = 0;
        self.runbeginView.playOrPauseBtn.alpha = 0;
        }];
}

#pragma mark - Unlock Action
- (void)unlockAction:(UIPanGestureRecognizer *)sender
{
    if (self.runbeginView.topLockBtn.alpha == 0 && self.runbeginView.photoBtn.alpha == 0) {
        __weak typeof(self) weakSelf = self;
        CGFloat panX = [sender translationInView:self.view].x;
        if (panX > 0) {

            if (panX <= 100) {
                CGRect rect = self.runbeginView.currentLable.frame;
                rect.origin.x = panX;
                self.runbeginView.currentLable.frame = rect;
                self.runbeginView.currentLable.alpha = 1 - 0.01 * panX;
            }
            if (panX > 89) {
                // unlock
                self.runbeginView.currentLable.frame = CGRectMake(self.runbeginView.unlockLable.x, self.runbeginView.unlockLable.y + self.runbeginView.unlockLable.h + 2, self.runbeginView.unlockLable.w, weakSelf.runbeginView.unlockLable.h);
                self.runbeginView.topLockBtn.alpha = 1;
                self.runbeginView.unlockLable.alpha = 0;
                self.runbeginView.photoBtn.alpha = 0;
                [UIView animateWithDuration:0.2 animations:^{
                    weakSelf.runbeginView.currentLable.alpha = 1;
                    weakSelf.runbeginView.startBtn.alpha = 1;
                    weakSelf.runbeginView.currentLable.text = CurrentMusicInfo;
                    weakSelf.runbeginView.lastSongBtn.alpha = 1;
                    weakSelf.runbeginView.nextSontBtn.alpha = 1;
                    weakSelf.runbeginView.playOrPauseBtn.alpha = 1;
                }];
            }
        }
    }
}

#pragma mark - Start BTN Action
- (void)startRun:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    if (sender.tag) {
        sender.tag = 0;
        // start-->pause
// runtimer resume
        [self resumeTimer];
        self.runbeginView.topLockBtn.alpha = 1;
        self.runbeginView.photoBtn.alpha = 0;
        sender.backgroundColor = [UIColor clearColor];
        [sender setImage:[UIImage imageNamed:@"runboy_pause_test_1"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            weakSelf.runbeginView.blurView.alpha = 0;
            CGRect rect = weakSelf.runbeginView.startBtn.frame;
            rect.origin.y = - weakSelf.runbeginView.startBtn.h * 0.5 + weakSelf.runbeginView.startBtn.y - [Tools autoSuitHeight:2 DesignDevice:iPhone4];
            weakSelf.runbeginView.startBtn.frame = rect;
            weakSelf.runbeginView.stopBtn.alpha = 1;
            rect = weakSelf.runbeginView.stopBtn.frame;
            rect.origin.y = weakSelf.runbeginView.stopBtn.h * 0.5 + weakSelf.runbeginView.stopBtn.y + [Tools autoSuitHeight:2 DesignDevice:iPhone4];
            weakSelf.runbeginView.stopBtn.frame = rect;
            weakSelf.runbeginView.stopBtn.alpha = 0;
        }];
        [self.runbeginView.showDataLable.layer removeAnimationForKey:@"flash"];
        [self.runbeginView.sequenceTimeLable.layer removeAnimationForKey:@"flash"];
        [self.runbeginView.reverseTimeLable.layer removeAnimationForKey:@"flash"];
        [self.runbeginView.dataUnitLabe.layer removeAllAnimations];
        NSLog(@"running pause....");
    }else{
        sender.tag = 1;
        //o-pause-->start--2
// runtimer pause
        [self pauseTimer];
        self.runbeginView.topLockBtn.alpha = 0;
        self.runbeginView.photoBtn.alpha = 1;
        
        sender.backgroundColor = [UIColor greenColor];
        [sender setImage:[UIImage imageNamed:@"runboy_play_btn_1"] forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            weakSelf.runbeginView.blurView.alpha = 1;
            CGRect rect = weakSelf.runbeginView.startBtn.frame;
                rect.origin.y = weakSelf.runbeginView.startBtn.h * 0.5 + weakSelf.runbeginView.startBtn.y + [Tools autoSuitHeight:2 DesignDevice:iPhone4];
                weakSelf.runbeginView.startBtn.frame = rect;
            weakSelf.runbeginView.stopBtn.alpha = 1;
                rect = weakSelf.runbeginView.stopBtn.frame;
                rect.origin.y = - weakSelf.runbeginView.stopBtn.h * 0.5 + weakSelf.runbeginView.stopBtn.y - [Tools autoSuitHeight:2 DesignDevice:iPhone4];
                weakSelf.runbeginView.stopBtn.frame = rect;
        } completion:^(BOOL finished) {
            [weakSelf.runbeginView.showDataLable.layer addAnimation:weakSelf.flasAni forKey:@"flash"];
            [weakSelf.runbeginView.sequenceTimeLable.layer addAnimation:weakSelf.flasAni forKey:@"flash"];
            [weakSelf.runbeginView.reverseTimeLable.layer addAnimation:weakSelf.flasAni forKey:@"flash"];
            [weakSelf.runbeginView.dataUnitLabe.layer addAnimation:weakSelf.flasAni forKey:@"flash"];
            NSLog(@"layer animation");
        }];
        NSLog(@"start run....");
    }
}

#pragma mark - Stop Run Action
// 3 sec after action
- (void)stopRun:(UILongPressGestureRecognizer *)sender
{
    __weak typeof(self) weakSelf = self;
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"3 sec after finger touch begin");
    // timer invalidate
        [self.runTimer invalidate];
        
        [self.runbeginView.stopBtn.imageView stopAnimating];
        [self.runbeginView.stopBtn setImage:[UIImage imageNamed:@"runboy_checkflag_1"] forState:UIControlStateNormal];
    // stop locationUpdate
        [self.locationManager stopUpdatingLocation];
    }else if (sender.state == UIGestureRecognizerStateEnded){
        NSLog(@"3 sec after finger lifted ");
#pragma mark - To Run End
        [RBlocationService presentAlert:[NSString stringWithFormat:@"album.count=%ld", (unsigned long)self.locationRotes.count] onViewController:self Completion:^{
//  SAVE in CORE DATA
            if (self.locationRotes.count) {
                
                if (![weakSelf isEntityExist:weakSelf.coreDataManager.managedObjectContext EntityName:@"Route" Identifier:weakSelf.currentDate])
                {
                    Route *routeModel = [NSEntityDescription insertNewObjectForEntityForName:@"Route" inManagedObjectContext:self.coreDataManager.managedObjectContext];
                    routeModel.userId = @"testuser01";
                    routeModel.beginDate = self.currentDate;
                    routeModel.averageVelocity = [NSNumber numberWithFloat:1.1];
                    routeModel.totalTime = self.runbeginView.reverseTimeLable.text;
                    CLLocationDistance distance = 0.0;
                    for (int i = 0; i < weakSelf.locationRotes.count - 1; i++)
                    {
                        Entity *locationModel = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:self.coreDataManager.managedObjectContext];
                        CLLocation *temp = weakSelf.locationRotes[i];
                        locationModel.latitude = [NSNumber numberWithFloat:temp.coordinate.latitude];
                        locationModel.longitude = [NSNumber numberWithFloat:temp.coordinate.longitude];
                        [routeModel addLocationObject:locationModel];
                        
                        CLLocation *next = weakSelf.locationRotes[i + 1];
                        distance += [next distanceFromLocation:temp];
                    }
                    routeModel.totalDistances = [NSNumber numberWithDouble:distance];
                    routeModel.averageVelocity = [NSNumber numberWithFloat:(distance / [self timeFromString:routeModel.totalTime])];
                    for (int i = 0; i < weakSelf.velocitiesArr.count; i++)
                    {
                        Velocity *velocityModel = [NSEntityDescription insertNewObjectForEntityForName:@"Velocity" inManagedObjectContext:self.coreDataManager.managedObjectContext];
                        NSString *temp = weakSelf.velocitiesArr[i];
                        temp = [temp substringToIndex:temp.length - 3];
                        velocityModel.speed = [NSNumber numberWithFloat:[temp doubleValue]];
                        [routeModel addVelocityObject:velocityModel];
                        NSLog(@"-----velocity %@", temp);
                    }
                    // save
                    [self.coreDataManager saveContext];
                
                }
            }
            NSLog(@"loction loc addr : %@", [weakSelf.coreDataManager applicationDocumentsDirectory]);
            RBrunningEndVC *endVC = [RBrunningEndVC new];
            endVC.beginDate = weakSelf.currentDate;
            [weakSelf.navigationController pushViewController:endVC animated:YES];
        }];
        
    }
}

// btn down action
- (void)tapStopRun:(UIButton *)sender
{
    NSLog(@"tap begin");
    // dynmic progress bar
    self.runbeginView.stopBtn.imageView.animationImages = self.imagesArr;
    self.runbeginView.stopBtn.imageView.animationImages = self.imagesArr;
    self.runbeginView.stopBtn.imageView.animationRepeatCount = 1;
    self.runbeginView.stopBtn.imageView.animationDuration = 3;
    [self.runbeginView.stopBtn.imageView startAnimating];
}

// in 3 sec lifted action
- (void)tapLiftStopBtn:(UIButton *)sender
{
    NSLog(@"in 3 sec tap lifted");
    [self.runbeginView.stopBtn.imageView stopAnimating];
}

#pragma mark - To Photo
- (void)photoAction
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"hard useable");
        [self showImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
    }else{
        NSLog(@"no support camero fuc");
    }
}

#pragma mark - imagePickerMethod
- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{

    if (self.capturedImages.count > 0)
    {
        [self.capturedImages removeAllObjects];
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)finishAndUpdate
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.imagePickerController = nil;
}

#pragma mark - imagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        NSLog(@"image saved in album");
    });
    [self finishAndUpdate];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - RunTimerFuc
- (void)pauseTimer
{
    if (![self.runTimer isValid]) {
        return ;
    }
    [self.runTimer setFireDate:[NSDate distantFuture]]; //如果给我一个期限，我希望是4001-01-01 00:00:00 +0000
}

- (void)resumeTimer
{
    
    if (![self.runTimer isValid]) {
        return ;
    }
    //[self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    [self.runTimer setFireDate:[NSDate date]];
    
}

#pragma mark - LocationService
- (void)locationService
{
    [RBlocationService beginLocation:self.locationManager inViewController:self];
}


#pragma mark - LocationDelegateMethod
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    /**
     *  save location
     */
    [self.locationRotes addObject:[locations lastObject]];
    
    /*                    ^
     *  save velocity     |
     *                    |
     **/
    CLLocation *updateLocation = locations.lastObject;
    self.runbeginView.sequenceTimeLable.text = [NSString stringWithFormat:@"%.2fm/s", updateLocation.speed];
    // save distancesArr
//    CLLocationDistance distance = [locations.lastObject distanceFromLocation:locations[locations.count - 1]];
//    [self.distancesArr addObject:[NSNumber numberWithDouble:distance]];
    
//    NSLog(@"running location begin distance:%f\n speed:%.2f", distance, updateLocation.speed);
}

// check the entity has been exist
- (BOOL)isEntityExist:(NSManagedObjectContext *)managedObjectContext EntityName:(NSString *)entityName Identifier:(NSDate *)identifierDate
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    BOOL result = NO;
    if (fetchedObjects == nil)
    {
        NSLog(@"no result");
    }
    else
    {
        for (Route *temp in fetchedObjects) {
            if ([temp.beginDate isEqual: identifierDate]) {
                result = YES;
            }else{
                result = NO;
            }
        }
    }
    return result;
}

//- (CGFloat)gettotlalDistance:(NSMutableArray * )distancesArr{
//    CGFloat distance = 0;
//    for (int i = 0; i < distancesArr.count; i++) {
//        NSNumber *temp = distancesArr[i];
//        distance += temp.doubleValue;
//    }
//    return distance;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"warning----warning----warning");
}
- (NSInteger)timeFromString:(NSString *)string{
    NSArray *strs = [string componentsSeparatedByString:@":"];
    NSString *den = strs.firstObject;
    NSString *dec = strs.lastObject;
    return den.intValue * 60 + dec.intValue;
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
