//
//  Tools.m
//  DoubanFake_homework
//
//  Created by marskey on 16/1/8.
//  Copyright © 2016年 lanou.com. All rights reserved.
//

#import "Tools.h"
@interface Tools()<UIScrollViewDelegate>

@end

@implementation Tools
+ (NSMutableAttributedString *)getCustomAttributedStringAppendingByString:(NSString *)string TargetString:(NSString *)targetString{
    NSString *coutText = [NSString stringWithFormat:@"%@ %@", targetString, string];
    NSMutableAttributedString *coutAtt = [[NSMutableAttributedString alloc]initWithString:coutText];
    NSInteger length = coutText.length - targetString.length;
    NSRange tempRange = NSMakeRange(targetString.length, length);
    [coutAtt addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:tempRange];
    
    
    return coutAtt;
}

+ (CGFloat)getSuitableHeightOfLableContentString:(NSString *)contentString OringeWidth:(CGFloat)width Font:(UIFont *)font{
    CGRect rect = [contentString boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :font} context:nil];
    return rect.size.height;
}

+ (CGFloat)getSuitableHeightOfImage:(UIImage *)image TagetWidth:(CGFloat)Width{
    CGFloat h = image.size.height;
    CGFloat w = image.size.width;
    CGFloat th = h / w * Width;
    return th;
}
+ (UIImage *)getImageFromURLString:(NSString *)URLString{
    NSURL *temp = [NSURL URLWithString:URLString];  // 不严谨 如果url不正确crash
    NSData *data = [NSData dataWithContentsOfURL:temp];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}
+ (void)addchildViewControllerNav:(UIViewController *)childViewController
                        ForTabBar:(UITabBarController *)tabbar
                  TabBarItemTitle:(NSString *)title
     TabBarImageNameOfNormalState:(NSString *)imageNameNormal
         TabBarImageNameOfSlected:(NSString *)imageNameSelected{
    UINavigationController *naV = [[UINavigationController alloc]initWithRootViewController:childViewController];
//    childViewController.tabBarItem.title = title;
    childViewController.title = title;
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
    titleLable.text = title;
    titleLable.font = [UIFont fontWithName:@"Arial" size:24];
    childViewController.navigationItem.titleView = titleLable;
    

    childViewController.tabBarItem.image = [[UIImage imageNamed:imageNameNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:imageNameSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    NSMutableDictionary *dicT = [NSMutableDictionary dictionary];
    NSMutableDictionary *dicD = [NSMutableDictionary dictionary];
    dicT[NSForegroundColorAttributeName] = [UIColor colorWithRed:74 / 255.0 green:152 / 255.0 blue:201 / 255.0 alpha:1.0];
    dicD[NSForegroundColorAttributeName] = [UIColor colorWithRed:42 / 255.0 green:51 / 255.0 blue:113 / 255.0 alpha:1.0];
    
    [childViewController.tabBarItem setTitleTextAttributes:dicT forState:UIControlStateNormal];
    [childViewController.tabBarItem setTitleTextAttributes:dicD forState:UIControlStateHighlighted];
    [tabbar addChildViewController:naV];
    
}
+ (void)addCustomTitleOfNavTargetNav:(UINavigationController *)nav TitleView:(NSString *)titleString{
    UILabel *userNavLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    userNavLable.text = titleString;
    userNavLable.font = [UIFont fontWithName:@"Arial" size:24];
    nav.navigationItem.titleView = userNavLable;
    
}

// add diffrent or delete one  data row
+ (void)mlf_targetDatabase:(NSString *)databaseName Infile:(NSString *)fileName Navbar:(NSString *)navbarName BackImage:(NSString *)backImageName BackgroundImage:(NSString *)backgroundImageName Add:(BOOL)isAdd{
    // 创建文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = false;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *pathOfColMovie = [path stringByAppendingPathComponent:fileName];
    if (![fileManager fileExistsAtPath:pathOfColMovie]) {
        // if not exist creat file
        result = [fileManager createDirectoryAtPath:pathOfColMovie withIntermediateDirectories:YES attributes:nil error:nil];
        if (result) {
            NSLog(@"%@ file creat success path:%@",fileName, pathOfColMovie);
        }else{
            NSLog(@"%@ file creat failure", fileName);
        }
    }
    NSLog(@"%@", pathOfColMovie);
    // 创建数据库
    NSString *pathMovieDB = [pathOfColMovie stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db", databaseName]];
    // 添加数据
    FMDatabase *db = [FMDatabase databaseWithPath:pathMovieDB];
    [db open];
    BOOL result2 = YES;
    if ([db open]) {
        [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS t_%@ (id INTEGER PRIMARY KEY, navbarname TEXT, backimagename TEXT, backgroundimagename TEXT);", databaseName]];

        // 遍历
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT %@ FROM t_%@", databaseName, navbarName]];
        while ([rs next]) {
            NSString * key = [rs stringForColumn:navbarName];
            if (key == navbarName) {
                result2 = NO;
            }
        }
        [rs close];
        // insert
        if (isAdd) {
            if (result2) {
                result = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO t_%@ (navbarname, backimagename, backgroundimagename) VALUES('%@', '%@', '%@')", databaseName, navbarName, backImageName, backgroundImageName]];
                if (result) {
                    NSLog(@"insert seccess");
                }else{
                    NSLog(@"insert failure");
                }
            }
        }
        else
            // delete
        {
            if (!result2) {
                result = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM t_%@ where navbarname = '%@'", databaseName, navbarName]];
                if (result) {
                    NSLog(@"delete seccess");
                    
                }else{
                    NSLog(@"delete failure");
                }
            }
        }
    }
    
    [db close];
}

+ (NSString *)returndbWithColumn:(NSString *)column DatabdName:(NSString *)databaseName Infile:(NSString *)fileName{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *pathOfFile = [path stringByAppendingPathComponent:fileName];
    NSString *pathofdb = [pathOfFile stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db", databaseName]];
    NSString * key = @"";
    FMDatabase *db = [FMDatabase databaseWithPath:pathofdb];
//    BOOL result = [db open];
    if ([db open]) {
        //take out
        FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT %@ FROM t_%@ where id = 1", column, databaseName]];
        while ([rs next]) {
            key = [rs stringForColumn:column];
//            NSLog(@"------%@", key);
        }
        [rs close];
    }
    
    [db close];
    return key;
}

+ (NSDictionary *)getJSONDataWithPath:(NSString *)path{
    NSDictionary *dic = [NSDictionary dictionary];
    NSString *temp = [[NSBundle mainBundle] pathForResource:path ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:temp];
    dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return dic;
}
+ (NSMutableAttributedString *)getAttString:(NSString *)string{
    NSMutableAttributedString *passwordAtt = [[NSMutableAttributedString alloc] initWithString:string];
    NSInteger length = string.length;
    [passwordAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:22] range:NSMakeRange(0, length)];
    return passwordAtt;
}

+ (void)dataAnalysis:(nullable NSString *)url TargetDataModel:(nullable id)model ReloadedTableview:(nullable UITableView *)tableview{
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *datatask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [model setValuesForKeysWithDictionary:dic];         // 此方法要写setvalues方法.m

        [tableview reloadData];
    }];
    [datatask resume];
}


+ (void)editeDataWithMovieName:(NSString *)name Movieid:(NSInteger)movieid Add:(BOOL)add{
    // 创建文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = false;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *pathOfColMovie = [path stringByAppendingPathComponent:@"collectionOfMovie"];
    if (![fileManager fileExistsAtPath:pathOfColMovie]) {
        // if not exist creat file
        result = [fileManager createDirectoryAtPath:pathOfColMovie withIntermediateDirectories:YES attributes:nil error:nil];
        if (result) {
            NSLog(@"movie file creat success :%@", pathOfColMovie);
        }else{
            NSLog(@"movie file creat failure");
        }
    }
    NSLog(@"%@", pathOfColMovie);
    // 创建数据库
    
    NSString *pathMovieDB = [pathOfColMovie stringByAppendingPathComponent:@"moviedb.db"];
    
    // 添加数据
    FMDatabase *db = [FMDatabase databaseWithPath:pathMovieDB];
    [db open];
    BOOL result2 = YES;
    if ([db open]) {
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_movielist (id INTEGER PRIMARY KEY, name TEXT, movieid INTEGER);"];
        // 遍历
        FMResultSet *rs = [db executeQuery:@"SELECT movieid FROM t_movielist"];
        while ([rs next]) {
            int dbmovieid = [rs intForColumn:@"movieid"];
            if (dbmovieid == movieid) {
                result2 = NO;
            }
        }
        [rs close];
        // insert
        if (add) {
            if (result2) {
                result = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO t_movielist (name, movieid) VALUES('%@', '%d')", name, movieid]];
                if (result) {
                    NSLog(@"insert seccess");
                }else{
                    NSLog(@"insert failure");
                }
            }
        }else{
            // delete
            if (!result2) {
                result = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM t_movielist where movieid = '%d'", movieid]];
                if (result) {
                    NSLog(@"delete seccess");
                    
                }else{
                    NSLog(@"delete failure");
                }
            }
        }
    }
    
    [db close];
}

+ (CGFloat)autoSuitFontSize:(CGFloat)fontSize
                 DesignDevice:(iPhoneModel)iphoneDeviceModel{
    CGFloat stFontSize = fontSize / [UIDevice getWidthFromeDevice:iphoneDeviceModel];
    iPhoneModel currentDevice = [[UIDevice currentDevice] getCurrentDevcieModel];
    switch (currentDevice) {
        case iPhone4:
            return stFontSize * [UIDevice getWidthFromeDevice:iPhone4];
            break;
        case iPhone5:
            return stFontSize * [UIDevice getWidthFromeDevice:iPhone5];
            break;
        case iPhone6:
            return stFontSize * [UIDevice getWidthFromeDevice:iPhone6];
            break;
        case iPhone6P:
            return stFontSize * [UIDevice getWidthFromeDevice:iPhone6P];
            break;
        default:
            break;
    }
}
+ (CGFloat)autoSuitHeight:(CGFloat)heigth DesignDevice:(iPhoneModel)iphoneDeviceModel{
    CGFloat stHeight = heigth / [UIDevice getHeightFromeDevice:iphoneDeviceModel];
    iPhoneModel currentDevice = [[UIDevice currentDevice] getCurrentDevcieModel];
    switch (currentDevice) {
        case iPhone4:
            return stHeight * [UIDevice getHeightFromeDevice:iPhone4];
            break;
        case iPhone5:
            return stHeight * [UIDevice getHeightFromeDevice:iPhone5];
            break;
        case iPhone6:
            return stHeight * [UIDevice getHeightFromeDevice:iPhone6];
            break;
        case iPhone6P:
            return stHeight * [UIDevice getHeightFromeDevice:iPhone6P];
            break;
        default:
            break;
    }
}

+ (UIView *)loadDownCountView:(NSInteger)number{
    UIView *bgview = [UIView new];
    bgview.backgroundColor = [UIColor blackColor];
    bgview.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    UILabel *numLable = [[UILabel alloc] initWithFrame:bgview.bounds];
    numLable.font = [UIFont systemFontOfSize:[Tools autoSuitFontSize:71 DesignDevice:iPhone4]];
    numLable.textColor = [UIColor whiteColor];
    numLable.textAlignment = NSTextAlignmentCenter;
    [bgview addSubview:numLable];
    // number change

    
    return bgview;
}
+ (CGFloat)inputValue:(CGFloat)value CurrentUnit:(UnitType)unit{
    if (unit == UnitFoot)
    {   // -->cm
        return value * 30.48;
    }
    else if (unit == UnitCM)
    {   // --> foot
        return value / 30.48;
    }
    else if (unit == UnitPound)
    {
        return value * 0.4536;
    }
    else
    {
        return value / 0.4536;
    }

}

@end
