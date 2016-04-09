//
//  RBrunDetailDataVC.m
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//
#import "RBCoreDataTool.h"
#import "RBrunDetailDataVC.h"
#import "Entity.h"
#import "RBvelocityTimeExcelView.h"
#import "Route.h"
@interface RBrunDetailDataVC ()<UIScrollViewDelegate, MKMapViewDelegate>
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) RBCoreDataTool *coreDataTool;
// excel
@property (nonatomic , retain) RBvelocityTimeExcelView *velocityView;
@end

@implementation RBrunDetailDataVC
- (NSMutableArray *)locationsArr{
    if (!_locationsArr) {
        _locationsArr = [NSMutableArray array];
    }
    return _locationsArr;
}
- (RBCoreDataTool *)coreDataTool
{
    if (!_coreDataTool) {
        _coreDataTool = [RBCoreDataTool defaultCoreDataManager];
    }
    return _coreDataTool;
}
- (MKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.3 * HEIGHT)];
        _mapView.mapType = MKMapTypeStandard;
        _mapView.delegate = self;
    }
    return _mapView;
}
// 速度时间表
- (RBvelocityTimeExcelView *)velocityView{
    if (!_velocityView) {
        _velocityView = [[RBvelocityTimeExcelView alloc] initWithFrame:CGRectMake(0, 0.31 * HEIGHT, WIDTH, 0.6 * HEIGHT) BeginDate:self.currentDate];
        _velocityView.backgroundColor = Mlf_Color(91, 199, 150);
    }
    return _velocityView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [self creatUI];

}
- (void)setup
{
    self.view.backgroundColor = Mlf_Color(248, 248, 248);
    self.navigationItem.title = @"数据详情";

}

- (void)creatUI
{
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.bgScrollView.backgroundColor = Mlf_Color(141, 286, 47);
    self.bgScrollView.contentSize = CGSizeMake(WIDTH, 2 * HEIGHT);
    [self.view addSubview:self.bgScrollView];

    [self.bgScrollView addSubview:self.mapView];
    [self netWork:self.currentDate];
    [RBlocationService drawWalkPolylineWithlocationArr:self.locationsArr onMap:self.mapView];
    
    [self.bgScrollView addSubview:self.velocityView];
    
    
}


- (void)netWork:(NSDate *)currentDate
{
    //查询请求
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Route" inManagedObjectContext:self.coreDataTool.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coreDataTool.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil)
    {
        NSLog(@"no result");
    }
    else
    {
        for (Route *temp  in fetchedObjects) {
            if ([temp.beginDate isEqual:currentDate]) {
                for (Entity *loc in temp.location)
                {
                    CLLocation *locT = [[CLLocation alloc] initWithLatitude:[loc.latitude doubleValue] longitude:[loc.longitude doubleValue]];
                    NSLog(@"loctemp ++++++ %@", locT);
                    [self.locationsArr addObject:locT];
                }
                NSLog(@"reverse success");
            }
        }
    }
    NSLog(@"%@", [self.coreDataTool applicationDocumentsDirectory]);
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *overlayRenderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        overlayRenderer.strokeColor = [UIColor redColor];
        overlayRenderer.fillColor = [UIColor blueColor];
        overlayRenderer.lineWidth = 3;
        return overlayRenderer;
    }
    return nil;
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
