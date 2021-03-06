//
//  SnAnswer.h
//  SnatterN
//
//  Created by Souvik Ray on 7/20/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SnQuestion, SnUser;

@interface SnAnswer : NSManagedObject

@property (nonatomic, retain) NSString * anstxt;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * objectid;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * tokens;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) SnQuestion *atoq;
@property (nonatomic, retain) SnUser *atou;

@end
