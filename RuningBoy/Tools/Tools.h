//
//  Tools.h
//  DoubanFake_homework
//
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "UIDevice+RBIPhoneModel.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RBlocationService.h"

typedef enum : NSUInteger {
    UnitFoot = 0,
    UnitCM,
    UnitPound,
    UnitKg
} UnitType;

@interface Tools : NSObject
// append a Attributedstring of orange color and 24.0 for the targetString 
+ (nullable NSMutableAttributedString *)getCustomAttributedStringAppendingByString:(nullable NSString *)string TargetString:(nullable NSString *)targetString;
// get a height of suitable lable
+ (CGFloat)getSuitableHeightOfLableContentString:(nullable NSString *)contentString
                                     OringeWidth:(CGFloat)width
                                            Font:(nullable UIFont *)font;

// get a height of suitable image
+ (CGFloat)getSuitableHeightOfImage:(nullable UIImage *)image TagetWidth:(CGFloat)Width;
//
+ (nullable UIImage *)getImageFromURLString:(nullable NSString *)URLString;
// add childnav&vc for TabBar
+ (void)addchildViewControllerNav:(nullable UIViewController *)childViewController
                        ForTabBar:(nullable UITabBarController *)tabbar
                     TabBarItemTitle:(nullable NSString *)title
        TabBarImageNameOfNormalState:(nullable NSString *)imageNameNormal
            TabBarImageNameOfSlected:(nullable NSString *)imageNameSelected;
+ (void)addCustomTitleOfNavTargetNav:(nullable UINavigationController *)nav TitleView:(nullable NSString *)titleString;
// nonof json turn to dic
+ (nullable NSDictionary *)getJSONDataWithPath:(nullable NSString *)path;
// turn to "Arial" 22.0
+ (nullable NSMutableAttributedString *)getAttString:(nullable NSString *)string;

//+ (UIView *)getRotationReplayImage:(NSArray<UIImage *>*)imageArr IntermenalTime:(CGFloat )time ScrollFrame:(CGSize)size;


// dataAnalysis
+ (void)dataAnalysis:(nullable NSString *)url TargetDataModel:(nullable id)model ReloadedTableview:(nullable UITableView *)tableview;
// add or delete database row in skin database
+ (void)mlf_targetDatabase:(nullable NSString *)databaseName Infile:(nullable NSString *)fileName Navbar:(nullable NSString *)navbarName BackImage:(nullable NSString *)backImageName BackgroundImage:(nullable NSString *)backgroundImageName Add:(BOOL)isAdd;
// return column of db
+ (nullable NSString *)returndbWithColumn:(nullable NSString *)column DatabdName:(nullable NSString *)databaseName Infile:(nullable NSString *)fileName;

//+ (void)editeDataWithMovieName:(NSString *)name Movieid:(NSInteger)movieid Add:(BOOL)add;

// AutoSuitFontSize---->standard width
+ (CGFloat)autoSuitFontSize:(CGFloat)fontSize
                 DesignDevice:(iPhoneModel)iphoneDeviceModel;
    
+ (CGFloat)autoSuitHeight:(CGFloat)heigth
             DesignDevice:(iPhoneModel)iphoneDeviceModel;
// load downcount view and launch
+ (nullable UIView *)loadDownCountView:(NSInteger)number;

// 英尺--厘米转换 磅-->千克
+ (CGFloat)inputValue:(CGFloat)value CurrentUnit:(UnitType)unit;





@end
