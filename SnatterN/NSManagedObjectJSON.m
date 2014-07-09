//
//  NSManagedObjectJSON.m
//  SnatterN
//
//  Created by Souvik Ray on 3/20/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import "NSManagedObjectJSON.h"

@implementation NSManagedObject (JSON)

- (NSDictionary *)JSONToCreateObjectOnServer {
    @throw [NSException exceptionWithName:@"JSONStringToCreateObjectOnServer Not Overridden" reason:@"Must override JSONStringToCreateObjectOnServer on NSManagedObject class" userInfo:nil];
    return nil;
}

@end
