//
//  RBCoreDataTool.h
//  RuningBoy
//
//  Created by marskey on 16/3/23.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface RBCoreDataTool : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)defaultCoreDataManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@end
