//
//  RBlocationService.m
//  RuningBoy
//
//  Created by marskey on 16/4/1.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBlocationService.h"

@implementation RBlocationService

+ (void)beginLocation:(CLLocationManager *)locmanaer inViewController:(UIViewController *)vc{
    // 检测是否开启定位功能
    if ([CLLocationManager locationServicesEnabled]) {
        // 适配 iOS 8.0 以后的机型
        if ([locmanaer respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            // 第一次打开应用 向用户请求"当使用时定位"的授权
            [locmanaer requestWhenInUseAuthorization];
            // 第2+ N次打开应用 向用户请求"始终使用定位"的授权
            [locmanaer requestAlwaysAuthorization];
        }
        // 开始定位
        [locmanaer startUpdatingLocation];
        // 开始确定方向
        [locmanaer startUpdatingHeading];
    }else{
        // 跳转设置页面设置定位服务
        NSLog(@"location services unenabled");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您没有开启定位服务" message:@"需要使用您的定位服务" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url])
            {
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [alertController addAction:alertAction];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc presentViewController:alertController animated:YES completion:nil];
        });
    }
}
+ (void)presentAlert:(NSString *)content onViewController:(UIViewController *)vc Completion:(completion)completion{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"NOTIFICATION" message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    completion();
        }];
    [alertController addAction:alertAction];
    [vc presentViewController:alertController animated:YES completion:^{
    }];
    
}
// drawRoute
+ (void)drawWalkPolylineWithlocationArr:(NSArray *)locationsArr onMap:(MKMapView *)mapView
{
    NSLog(@"%s", __FUNCTION__);
    // 轨迹点数组个数
    NSUInteger count = locationsArr.count;
    // 动态分配存储空间
    // MapPoint是个结构体：地理坐标点，用直角地理坐标表示 X：横坐标 Y：纵坐标
    MKMapPoint *tempPoints = malloc(sizeof(MKMapPoint) * locationsArr.count);
    // 遍历数组
    
    [locationsArr enumerateObjectsUsingBlock:^(CLLocation *location, NSUInteger idx, BOOL *stop) {
        MKMapPoint locationPoint = MKMapPointForCoordinate(location.coordinate);

        tempPoints[idx] = locationPoint;
    }];

    MKPolyline *polyLine = [MKPolyline polylineWithPoints:tempPoints count:count];
    //添加路线,绘图
    [mapView addOverlay:polyLine];
    // 清空 tempPoints 临时数组
    tempPoints = NULL;
    // show region rect
    MKMapPoint northwestCoord; /*= CLLocationCoordinate2DMake(MAXFLOAT, MAXFLOAT);*/
    MKMapPoint southnorthCoord; /*= CLLocationCoordinate2DMake(0, 0);*/
    for (int i = 0; i < locationsArr.count; i++) {
        if (i == 0) {
            CLLocation *location = locationsArr[0];
            MKMapPoint locpoint = MKMapPointForCoordinate(location.coordinate);
            northwestCoord = locpoint;
            southnorthCoord = locpoint;
        }else{
            CLLocation *temp = locationsArr[i];
            MKMapPoint temppoint = MKMapPointForCoordinate(temp.coordinate);
            northwestCoord.x = temppoint.x < northwestCoord.x ? temppoint.x : northwestCoord.x;
            northwestCoord.y = temppoint.y < northwestCoord.y ? temppoint.y : northwestCoord.y;
            southnorthCoord.x = temppoint.x > southnorthCoord.x ? temppoint.x : southnorthCoord.x;
            southnorthCoord.y = temppoint.y > southnorthCoord.y ? temppoint.y : southnorthCoord.y
            ;
        }
    }
//    if (locationsArr.count > 1)
//    {
        MKMapRect rect = MKMapRectMake(northwestCoord.x , northwestCoord.y , 10 + southnorthCoord.x - northwestCoord.x, 10 + southnorthCoord.y - northwestCoord.y);
        [mapView setVisibleMapRect:rect animated:YES];
//    }
//    else if (locationsArr.count == 1)
//    {
//        CLLocation *temp = [locationsArr firstObject];
//        [mapView setRegion:MKCoordinateRegionMake(temp.coordinate, MKCoordinateSpanMake(0.03, 0.03)) animated:YES];
//    }
    
    
    
}


@end
