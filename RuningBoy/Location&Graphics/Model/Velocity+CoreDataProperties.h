//
//  Velocity+CoreDataProperties.h
//  RuningBoy
//
//  Created by marskey on 16/4/5.
//  Copyright © 2016年 marskey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Velocity.h"

NS_ASSUME_NONNULL_BEGIN

@interface Velocity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *speed;
@property (nullable, nonatomic, retain) NSManagedObject *route;

@end

NS_ASSUME_NONNULL_END
