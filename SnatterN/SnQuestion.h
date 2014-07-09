//
//  SnQuestion.h
//  SnatterN
//
//  Created by Souvik Ray on 2/27/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SnQuestion : NSManagedObject

@property (nonatomic, retain) NSString * questxt;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSSet *qtoa;
@property (nonatomic, retain) NSManagedObject *qtou;
@end

@interface SnQuestion (CoreDataGeneratedAccessors)

- (void)addQtoaObject:(NSManagedObject *)value;
- (void)removeQtoaObject:(NSManagedObject *)value;
- (void)addQtoa:(NSSet *)values;
- (void)removeQtoa:(NSSet *)values;

@end
