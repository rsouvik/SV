//
//  SnUser.h
//  SnatterN
//
//  Created by Souvik Ray on 2/27/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SnQuestion;

@interface SnUser : NSManagedObject

@property (nonatomic, retain) NSString * socialID;
@property (nonatomic, retain) NSString * uname;
@property (nonatomic, retain) NSNumber *tokens;
@property (nonatomic, retain) NSNumber *rating;
@property (nonatomic, retain) NSSet *utoa;
@property (nonatomic, retain) NSSet *utoq;
@end

@interface SnUser (CoreDataGeneratedAccessors)

- (void)addUtoaObject:(NSManagedObject *)value;
- (void)removeUtoaObject:(NSManagedObject *)value;
- (void)addUtoa:(NSSet *)values;
- (void)removeUtoa:(NSSet *)values;

- (void)addUtoqObject:(SnQuestion *)value;
- (void)removeUtoqObject:(SnQuestion *)value;
- (void)addUtoq:(NSSet *)values;
- (void)removeUtoq:(NSSet *)values;

@end
