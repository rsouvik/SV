//
//  SnQuestion.m
//  SnatterN
//
//  Created by Souvik Ray on 2/27/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import "SnQuestion.h"
#import "NSManagedObjectJSON.h"
#import "SnSyncEngine.h"


@implementation SnQuestion

@dynamic questxt;
@dynamic timestamp;
@dynamic timer;
@dynamic tokens;
@dynamic qtoa;
@dynamic qtou;

- (void)addQtoa:(NSSet *)values {
    
}

- (void)removeQtoa:(NSSet *)values {
    
}

- (NSDictionary *)JSONToCreateObjectOnServer {
    NSString *jsonString = nil;
    NSDictionary *date = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Date", @"__type",
                          [[SnSyncEngine sharedEngine] dateStringForAPIUsingDate:self.timestamp], @"iso" , nil];
    
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.questxt, @"questxt",
                                    date, @"date", self.tokens, @"tokens",
                                    self.timer, @"timer", nil];
    
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
