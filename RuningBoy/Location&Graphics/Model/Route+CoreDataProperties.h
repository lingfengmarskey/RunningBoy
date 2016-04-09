//
//  Route+CoreDataProperties.h
//  RuningBoy
//
//  Created by marskey on 16/4/5.
//  Copyright © 2016年 marskey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Route.h"

NS_ASSUME_NONNULL_BEGIN

@interface Route (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *averageVelocity;
@property (nullable, nonatomic, retain) NSNumber *totalDistances;
@property (nullable, nonatomic, retain) NSString *totalTime;
@property (nullable, nonatomic, retain) NSString *feedBack;
@property (nullable, nonatomic, retain) NSString *runState;
@property (nullable, nonatomic, retain) NSString *userId;
@property (nullable, nonatomic, retain) NSDate *beginDate;
@property (nullable, nonatomic, retain) NSArray<Entity *> *location;
@property (nullable, nonatomic, retain) NSArray<Velocity *> *velocity;

@end

@interface Route (CoreDataGeneratedAccessors)

- (void)addLocationObject:(Entity *)value;
- (void)removeLocationObject:(Entity *)value;
- (void)addLocation:(NSArray<Entity *> *)values;
- (void)removeLocation:(NSArray<Entity *> *)values;

- (void)addVelocityObject:(Velocity *)value;
- (void)removeVelocityObject:(Velocity *)value;
- (void)addVelocity:(NSArray<Velocity *> *)values;
- (void)removeVelocity:(NSArray<Velocity *> *)values;

@end

NS_ASSUME_NONNULL_END
