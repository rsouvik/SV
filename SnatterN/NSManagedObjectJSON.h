//
//  NSManagedObjectJSON.h
//  SnatterN
//
//  Created by Souvik Ray on 3/20/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface NSManagedObject (JSON)

- (NSDictionary *)JSONToCreateObjectOnServer;

@end
