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
@dynamic qtoa;
@dynamic qtou;

- (NSDictionary *)JSONToCreateObjectOnServer {
    NSString *jsonString = nil;
    NSDictionary *date = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"Date", @"__type",
                          [[SnSyncEngine sharedEngine] dateStringForAPIUsingDate:self.timestamp], @"iso" , nil];
    
    /*NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.name, @"name",
                                    self.giftIdeas, @"giftIdeas",
                                    self.facebook, @"facebook",
                                    date, @"date", nil];*/
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.questxt, @"questxt",
                                    date, @"date", nil];
    
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
