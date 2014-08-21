//
//  SnUser.h
//  SnatterN
//
//  Created by Souvik Ray on 7/20/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SnAnswer, SnQuestion;

@interface SnUser : NSManagedObject

@property (nonatomic, retain) NSString * objectid;
@property (nonatomic, retain) NSString * socialID;
@property (nonatomic, retain) NSString * uname;
@property (nonatomic, retain) NSNumber * tokens;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSSet *utoa;
@property (nonatomic, retain) NSSet *utoq;
@end

@interface SnUser (CoreDataGeneratedAccessors)

- (void)addUtoaObject:(SnAnswer *)value;
- (void)removeUtoaObject:(SnAnswer *)value;
- (void)addUtoa:(NSSet *)values;
- (void)removeUtoa:(NSSet *)values;

- (void)addUtoqObject:(SnQuestion *)value;
- (void)removeUtoqObject:(SnQuestion *)value;
- (void)addUtoq:(NSSet *)values;
- (void)removeUtoq:(NSSet *)values;

@end
