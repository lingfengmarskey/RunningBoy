//
//  Entity+CoreDataProperties.h
//  RuningBoy
//
//  Created by marskey on 16/4/5.
//  Copyright © 2016年 marskey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSManagedObject *route;

@end

NS_ASSUME_NONNULL_END
