//
//  SnAPI.h
//  SnatterN
//
//  Created by Souvik Ray on 2/25/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"

typedef void (^JSONResponseBlock)(NSDictionary* json);

NSDictionary *mapsynccommand = [[NSDictionary alloc] initWithObjectsAndKeys:@"SnQuestion",@"syncuserques",@"SnAnswer",@"syncuseranswer" nil];

@interface API : AFHTTPClient

@property (strong, nonatomic) NSDictionary* user;

+(API*)sharedInstance;
//check whether there's an authorized user
-(BOOL)isAuthorized;
//send an API command to the server
-(void)commandWithParams:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock;
-(void)commandPost:(NSMutableDictionary*)params onCompletion:(JSONResponseBlock)completionBlock;
-(void)commandGet:(NSString*)params onCompletion:(JSONResponseBlock)completionBlock;
-(NSURL*)urlForImageWithId:(NSNumber*)IdPhoto isThumb:(BOOL)isThumb;

- (NSMutableURLRequest *)GETRequestForClass:(NSString *)className parameters:(NSDictionary *)parameters;
- (NSMutableURLRequest *)GETRequestForAllRecordsOfClass:(NSString *)className updatedAfterDate:(NSDate *)updatedDate;
- (NSMutableURLRequest *)GETRequestForAllRecordsOfClass:(NSString *)className foruser:(NSString *)user updatedAfterDate:(NSDate *)updatedDate;
- (NSMutableURLRequest *)POSTRequestForClass:(NSString *)className parameters:(NSDictionary *)parameters;
- (NSMutableURLRequest *)DELETERequestForClass:(NSString *)className forObjectWithId:(NSString *)objectId;

@end

