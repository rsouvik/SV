//
//  SnUser.m
//  SnatterN
//
//  Created by Souvik Ray on 7/20/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import "SnUser.h"
#import "SnAnswer.h"
#import "SnQuestion.h"
#import "NSManagedObjectJSON.h"


@implementation SnUser

@dynamic objectid;
@dynamic socialID;
@dynamic uname;
@dynamic tokens;
@dynamic rating;
@dynamic utoa;
@dynamic utoq;

- (NSDictionary *)JSONToCreateObjectOnServer {
    NSString *jsonString = nil;
    //NSDictionary *date = [NSDictionary dictionaryWithObjectsAndKeys:
    //                    @"Date", @"__type",
    //                  [[SDSyncEngine sharedEngine] dateStringForAPIUsingDate:self.date], @"iso" , nil];
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.uname, @"uname",
                                    self.socialID, @"socialID",
                                    self.rating, @"rating",
                                    self.tokens, @"tokens",
                                    nil];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:jsonDictionary
                        options:NSJSONWritingPrettyPrinted
                        error:&error];
    if (!jsonData) {
        NSLog(@"Error creaing jsonData: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonDictionary;
}

@end
