//
//  JSONBuilder.h
//  SnatterN
//
//  Created by Souvik Ray on 1/10/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONBuilder : NSObject

+ (NSArray *)groupsFromJSON:(NSData *)objectNotation error:(NSError **)error;
+ (NSArray *)postsFromJSON:(NSDictionary *)objectNotation;
+ (NSArray *)notifsFromJSON:(NSDictionary *)objectNotation;
//+ (NSArray *)phrFromJSON:(NSDictionary *)objectNotation;

@end
