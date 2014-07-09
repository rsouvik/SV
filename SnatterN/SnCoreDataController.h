//
//  SnCoreDataController.h
//  SnatterN
//
//  Created by Souvik Ray on 3/1/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SnCoreDataController : NSObject

+ (id)sharedInstance;

- (NSURL *)applicationDocumentsDirectory;

- (NSManagedObjectContext *)masterManagedObjectContext;
- (NSManagedObjectContext *)backgroundManagedObjectContext;
- (NSManagedObjectContext *)newManagedObjectContext;
- (void)saveMasterContext;
- (void)saveBackgroundContext;
- (NSManagedObjectModel *)managedObjectModel;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

@end
