//
//  RBvelocityTimeExcelView.m
//  RuningBoy
//
//  Created by marskey on 16/4/6.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBvelocityTimeExcelView.h"
#import "Entity.h"
#import "Route.h"
#import "Velocity.h"
@interface RBvelocityTimeExcelView()
@property (nonatomic, retain) RBCoreDataTool *coreDataManager;
@property (nonatomic, retain) NSArray *dataArr;


@end


@implementation RBvelocityTimeExcelView
- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (instancetype)initWithFrame:(CGRect)frame BeginDate:(NSDate *)beginDate
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews:beginDate];
    }
    return self;
}

- (RBCoreDataTool *)coreDataManager
{
    if (!_coreDataManager) {
        _coreDataManager = [RBCoreDataTool defaultCoreDataManager];
    }
    return _coreDataManager;
}

- (void)creatSubViews:(NSDate *)beginDate
{
    self.backgroundColor = Mlf_Color(91, 199, 150);
    self.dataArr = [self searchEntity:beginDate];
    NSLog(@"%s",__FUNCTION__);
    
//    [self drawSapeLayer];
}
// get datas
- (NSArray *)searchEntity:(NSDate *)beginDate
{
    
    NSLog(@"%s", __FUNCTION__);
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Route" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *array = [NSMutableArray array];
    BOOL result = NO;
    if (fetchedObjects == nil)
    {
        NSLog(@"=========fetch Object no result ");

    }
    else
    {
        result = YES;
        for (Route *temp in fetchedObjects)
        {
            if ([temp.beginDate isEqual: beginDate])
            {
                for (Velocity *speed in temp.velocity) {
                    [array addObject:speed];
                }
                break;
            }
        }
    }
    if (result) {
        return  array;
    }else{
        return nil;
    }
}

// draw my excel
- (void)drawRect:(CGRect)rect{
    NSLog(@"%s", __FUNCTION__);
    
    CGFloat max = 0;
    CGFloat min = MAXFLOAT;
    NSInteger  count = self.dataArr.count;
    for (Velocity *temp in self.dataArr) {
        CGFloat num = ABS(temp.speed.floatValue);
        max = max > num ? max : num;
        min = min < num ? min : num;
    }
    
    CGFloat hei = rect.size.height;
    CGFloat wid = rect.size.width;
    if (max != min) {
        
    
        CGFloat X =  (wid - 0.2 * hei) / count * 1.0;
        CGFloat H = hei * 0.8 / max;
        NSLog(@"=======X=%f, y = %f", X, H);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // curve
        CGMutablePathRef pathRoute = CGPathCreateMutable();
        CGPathMoveToPoint(pathRoute, nil, 0.1 * hei, 0.9 * hei);
        for (int i = 0; i < self.dataArr.count; i++) {
            Velocity *temp = self.dataArr[i];
            CGPathAddLineToPoint(pathRoute, nil, 0.1 * hei + (i + 1) * X,0.9 * hei - ABS(temp.speed.floatValue) * H);
            CGContextAddPath(context, pathRoute);
            NSLog(@"drawing%f", temp.speed.floatValue);
        }
        CGPathAddLineToPoint(pathRoute, nil, wid - 0.1 * hei, 0.9 * hei);
        CGContextAddPath(context, pathRoute);
        
        CGContextSetRGBStrokeColor(context, 1, 1, 1, 1.0);
        CGContextSetLineWidth(context, 4);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextDrawPath(context, kCGPathStroke);
        
        [self drawLinearGradient:context path:pathRoute startColor:Mlf_Color(248, 248, 248).CGColor endColor:Mlf_Color(91, 199, 150).CGColor];
        
        CGPathRelease(pathRoute);
        // baselines
        CGMutablePathRef path = CGPathCreateMutable();
        for (int i = 0; i < 3; i++) {
            CGPathMoveToPoint(path, nil, 0.1 * hei, 0.1 * hei + 0.4 * i * hei);
            CGPathAddLineToPoint(path, nil, wid - 0.1 * hei, 0.1 * hei + 0.4 * i * hei);
            CGContextAddPath(context, path);
        }
        
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1);
        CGContextSetLineWidth(context, 2.0);
        CGContextDrawPath(context, kCGPathFillStroke);
        CGPathRelease(path);
    }

}

- (void)drawSapeLayer{
    CGFloat max = 0;
    CGFloat min = MAXFLOAT;
    NSInteger  count = self.dataArr.count;
    for (Velocity *temp in self.dataArr) {
        CGFloat num = ABS(temp.speed.floatValue);
        max = max > num ? max : num;
        min = min < num ? min : num;
    }
    
    CGFloat hei = self.bounds.size.height;
    CGFloat wid = self.bounds.size.width;
    if (max != min) {
        
        
        CGFloat X =  (wid - 0.2 * hei) / count * 1.0;
        CGFloat H = hei * 0.8 / max;
        NSLog(@"=======X=%f, y = %f", X, H);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // curve
        CGMutablePathRef pathRoute = CGPathCreateMutable();
        CGPathMoveToPoint(pathRoute, nil, 0.1 * hei, 0.9 * hei);
        for (int i = 0; i < self.dataArr.count; i++) {
            Velocity *temp = self.dataArr[i];
            CGPathAddLineToPoint(pathRoute, nil, 0.1 * hei + (i + 1) * X,0.9 * hei - ABS(temp.speed.floatValue) * H);
            CGContextAddPath(context, pathRoute);
            NSLog(@"drawing%f", temp.speed.floatValue);
        }
        CGPathAddLineToPoint(pathRoute, nil, wid - 0.1 * hei, 0.9 * hei);
        CAShapeLayer *shapLayer = [CAShapeLayer layer];
        shapLayer.path = pathRoute;
        shapLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapLayer.strokeStart = 0.f;
        shapLayer.strokeEnd = 1.0f;
        shapLayer.lineWidth = 2.0f;
//        CGContextAddPath(context, pathRoute);
        [self.layer addSublayer:shapLayer];
        
        
//        CGContextSetRGBStrokeColor(context, 1, 1, 1, 1.0);
//        CGContextSetLineWidth(context, 4);
//        CGContextSetLineJoin(context, kCGLineJoinRound);
//        CGContextDrawPath(context, kCGPathStroke);
        
        [self drawLinearGradient:context path:pathRoute startColor:Mlf_Color(248, 248, 248).CGColor endColor:Mlf_Color(91, 199, 150).CGColor];
        
        CGPathRelease(pathRoute);
        // baselines
//        CGMutablePathRef path = CGPathCreateMutable();
//        for (int i = 0; i < 3; i++) {
//            CGPathMoveToPoint(path, nil, 0.1 * hei, 0.1 * hei + 0.4 * i * hei);
//            CGPathAddLineToPoint(path, nil, wid - 0.1 * hei, 0.1 * hei + 0.4 * i * hei);
//            CGContextAddPath(context, path);
//        }
//        
//        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1);
//        CGContextSetLineWidth(context, 2.0);
//        CGContextDrawPath(context, kCGPathFillStroke);
//        CGPathRelease(path);
    }
    
}
- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}
@end
