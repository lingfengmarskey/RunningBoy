//
//  RBlocationService.h
//  RuningBoy
//
//  Created by marskey on 16/4/1.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^completion)();

@interface RBlocationService : NSObject

+ (void)beginLocation:(CLLocationManager *)locmanaer inViewController:(UIViewController *)vc;

+ (void)presentAlert:(NSString *)content onViewController:(UIViewController *)vc Completion:(completion)completion;

+ (void)drawWalkPolylineWithlocationArr:(NSArray *)locationsArr onMap:(MKMapView *)mapView;
@end
