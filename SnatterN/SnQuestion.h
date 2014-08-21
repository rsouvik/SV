//
//  SnQuestion.h
//  SnatterN
//
//  Created by Souvik Ray on 7/20/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SnAnswer, SnUser;

@interface SnQuestion : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * objectid;
@property (nonatomic, retain) NSString * questxt;
@property (nonatomic, retain) NSNumber * syncStatus;
@property (nonatomic, retain) NSNumber * timer;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * tokens;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSSet *qtoa;
@property (nonatomic, retain) SnUser *qtou;
@end

@interface SnQuestion (CoreDataGeneratedAccessors)

- (void)addQtoaObject:(SnAnswer *)value;
- (void)removeQtoaObject:(SnAnswer *)value;
- (void)addQtoa:(NSSet *)values;
- (void)removeQtoa:(NSSet *)values;

@end
