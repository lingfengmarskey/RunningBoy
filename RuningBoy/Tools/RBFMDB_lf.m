//
//  RBFMDB_lf.m
//  RuningBoy
//
//  Created by marskey on 16/4/10.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBFMDB_lf.h"
#import <FMDB.h>
@implementation RBFMDB_lf

// get a subpath in searchPathDirectory
+ (NSString *)getPathIn:(NSSearchPathDirectory)directiory
                     Name:(NSString *)name{
    NSString *path = NSSearchPathForDirectoriesInDomains(directiory, NSUserDomainMask, YES).lastObject;
    NSString *newPath = [path stringByAppendingPathComponent:name];
    return newPath;
}

+ (BOOL)creatTableWithName:(NSString *)name InDatabese:(FMDatabase *)dataBase{
    BOOL result = NO;
    result = [dataBase open];
    if (result) {
        [dataBase executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS t_%@ (id INTEGER PRIMARY KEY, gender INTEGER, height REAL, weight REAL);", name]];
    }else{
        NSLog(@"open db failure %s", __FUNCTION__);
    }
    return result;
}

@end
