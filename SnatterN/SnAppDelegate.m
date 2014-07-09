//
//  SnAppDelegate.m
//  SnatterN
//
//  Created by Souvik Ray on 12/7/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import "SnAppDelegate.h"
#import "Question.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "BaseViewController.h"
#import "SplashViewController.h"
#import <FacebookSDK/FBSessionTokenCachingStrategy.h>
#import "SnSyncEngine.h"
#import "SnAnswer.h"
#import "SnQuestion.h"

@implementation SnAppDelegate{
    NSMutableArray *players;
}

@synthesize window = _window,
navigationController = _navigationController,
mainViewController = _mainViewController,
loginViewController = _loginViewController,
baseViewController = _baseViewController,
isNavigating = _isNavigating;

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//@implementation SnAppDelegate

/*- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    players = [NSMutableArray arrayWithCapacity:20];
	Question *player = [[Question alloc] init];
	player.text = @"Bill Evans";
	player.game = @"Tic-Tac-Toe";
	player.rating = 4;
	[players addObject:player];
	player = [[Question alloc] init];
	player.text = @"Oscar Peterson";
	player.game = @"Spin the Bottle";
	player.rating = 5;
	[players addObject:player];
	player = [[Question alloc] init];
	player.text = @"Dave Brubeck";
	player.game = @"Texas Hold’em Poker";
	player.rating = 2;
	[players addObject:player];
	UITabBarController *tabBarController =
    (UITabBarController *)self.window.rootViewController;
	UINavigationController *navigationController =
    [[tabBarController viewControllers] objectAtIndex:0];
	HomeViewController *playersViewController =
    [[navigationController viewControllers] objectAtIndex:0];
	playersViewController.questions = players;
    return YES;
}*/

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Facebook SDK * login flow *
    // Attempt to handle URLs to complete any auth (e.g., SSO) flow.
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication fallbackHandler:^(FBAppCall *call) {
        // Facebook SDK * App Linking *
        // For simplicity, this sample will ignore the link if the session is already
        // open but a more advanced app could support features like user switching.
        if (call.accessTokenData) {
            if ([FBSession activeSession].isOpen) {
                NSLog(@"INFO: Ignoring app link because current session is open.");
            }
            else {
                [self handleAppLink:call.accessTokenData];
            }
        }
    }];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //This is just for testing
    /*NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *failedBankInfo = [NSEntityDescription
                                      insertNewObjectForEntityForName:@"SnQuestion"
                                      inManagedObjectContext:context];
    [failedBankInfo setValue:@"Test Bank" forKey:@"questxt"];
    [failedBankInfo setValue:[NSDate date] forKey:@"timestamp"];
    NSMutableSet *answers = [[NSMutableSet alloc] init];
    NSManagedObject *failedBankDetails = [NSEntityDescription
                                            insertNewObjectForEntityForName:@"SnAnswer"
                                            inManagedObjectContext:context];
    [failedBankDetails setValue:[NSDate date] forKey:@"timestamp"];
    [failedBankDetails setValue:@"Test bank ans" forKey:@"anstxt"];
    [failedBankDetails setValue:failedBankInfo forKey:@"atoq"];
    [answers addObject:failedBankDetails];
    [failedBankInfo setValue:answers forKey:@"qtoa"];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }*/ 
    
    //Register for sync
    [[SnSyncEngine sharedEngine] registerNSManagedObjectClassToSync:[SnAnswer class]];
    [[SnSyncEngine sharedEngine] registerNSManagedObjectClassToSync:[SnQuestion class]];

    // If you have not added the -ObjC linker flag, you may need to uncomment the following line because
    // Nib files require the type to have been loaded before they can do the wireup successfully.
    // http://stackoverflow.com/questions/1725881/unknown-class-myclass-in-interface-builder-file-error-at-runtime
    // [FBProfilePictureView class];
    
    /*self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     [self resetMainViewController];
     self.loginViewController = [[SCLoginViewController alloc] initWithNibName:@"SCLoginViewController"
     bundle:nil];
     self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.loginViewController];
     self.navigationController.delegate = self;
     self.window.rootViewController = self.navigationController;
     
     [self.window makeKeyAndVisible];*/
    
    //Notifications
    [[NotificarePushLib shared] launch];
    [[NotificarePushLib shared] setDelegate:self];
    [[NotificarePushLib shared] registerForWebsockets];
    
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.mainViewController=[stryBoard instantiateViewControllerWithIdentifier:@"splashview"];
    //self.mainViewController=[stryBoard instantiateViewControllerWithIdentifier:@"baseview"];
    self.navigationController=[[UINavigationController alloc]
                                 initWithRootViewController:self.mainViewController];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationController;
    
    /*UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.mainViewController=[stryBoard instantiateViewControllerWithIdentifier:@"baseview"];
    
    self.window.rootViewController = self.mainViewController;*/
    
    /*self.loginViewController=[stryBoard instantiateViewControllerWithIdentifier:@"loginview"];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.loginViewController];
    [self.mainViewController presentModalViewController:self.navigationController animated:NO];*/
    
    
    //self.mainViewController = [[HomeViewController alloc]
      //                         initWithNibName:@"HomeViewController" bundle:nil];
    //self.navigationController = [[UINavigationController alloc]
      //                           initWithRootViewController:self.mainViewController];
    //self.navigationController = [stryBoard instantiateViewControllerWithIdentifier:@"navview"];

    //self.window.rootViewController = self.navigationController;
    //self.window.rootViewController = self.mainViewController;
    [self.window makeKeyAndVisible];
    
    // Facebook SDK * pro-tip *
    // We take advantage of the `FBLoginView` in our loginViewController, which can
    // automatically open a session if there is a token cached. If we were not using
    // that control, this location would be a good place to try to open a session
    // from a token cache.
    
    // See if the app has a valid token for the current state.
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // To-do, show logged in view
        NSLog(@"Active FB Session.");
        [self showLoggedinView];
        //[self openSession];
    } else {
        // No, display the login page.
        NSLog(@"NonActive FB Session.");
        [self showLoginView];
    }
    
    return YES;
}

// Helper method to wrap logic for handling app links.
- (void)handleAppLink:(FBAccessTokenData *)appLinkToken {
    // Initialize a new blank session instance...
    FBSession *appLinkSession = [[FBSession alloc] initWithAppID:nil
                                                     permissions:nil
                                                 defaultAudience:FBSessionDefaultAudienceNone
                                                 urlSchemeSuffix:nil
                                              tokenCacheStrategy:[FBSessionTokenCachingStrategy nullCacheInstance] ];
    [FBSession setActiveSession:appLinkSession];
    // ... and open it from the App Link's Token.
    [appLinkSession openFromAccessTokenData:appLinkToken
                          completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                              // Forward any errors to the FBLoginView delegate.
                              if (error) {
                                  [self.loginViewController loginView:nil handleError:error];
                              }
                          }];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppEvents activateApp];
    
    // Facebook SDK * login flow *
    // We need to properly handle activation of the application with regards to SSO
    // (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActive];
    
    //sync
    [[SnSyncEngine sharedEngine] startSync];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [FBSession.activeSession close];
}

- (void)showLoggedinView
{
    /*UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    BaseViewController* baseViewController=[stryBoard instantiateViewControllerWithIdentifier:@"baseview"];
    [self.loginViewController presentViewController:baseViewController animated:NO completion:nil];*/
    
    /*[self.window setRootViewController:self.mainViewController];
    [self.mainViewController setSelectedIndex:0];
    [self.window makeKeyAndVisible];*/
    
    //UITabBarController *tabbar = (UITabBarController *)self.window.rootViewController;
    //LoginViewController *loginController = [tabbar.storyboard instantiateViewControllerWithIdentifier:@"loginview"];
    //loginController.delegate = self;
    //[tabbar presentModalViewController:loginController animated:YES];
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *topViewController = [self.navigationController topViewController];
    
    /*BaseViewController* baseViewController=[stryBoard instantiateViewControllerWithIdentifier:@"baseview"];
    [topViewController presentModalViewController:baseViewController animated:NO];*/
    
    SplashViewController* splashViewController=[stryBoard instantiateViewControllerWithIdentifier:@"splashview"];
    [topViewController presentModalViewController:splashViewController animated:NO];
}

- (void)showLoginView
{
    /*UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    BaseViewController* baseViewController=[stryBoard instantiateViewControllerWithIdentifier:@"baseview"];
    [self.loginViewController presentViewController:baseViewController animated:YES completion:nil];*/
    
    //UITabBarController *tabbar = (UITabBarController *)self.window.rootViewController;
    //LoginViewController *loginController = [tabbar.storyboard instantiateViewControllerWithIdentifier:@"loginview"];
    //loginController.delegate = self;
    //[tabbar presentModalViewController:loginController animated:NO];}

    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *topViewController = [self.navigationController topViewController];

    LoginViewController* loginViewController=[stryBoard instantiateViewControllerWithIdentifier:@"loginview"];
    [topViewController presentModalViewController:loginViewController animated:NO];
}

/*- (void)showLoginView
{
    UIViewController *topViewController = [self.navigationController topViewController];
    
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    LoginViewController* loginViewController=[stryBoard instantiateViewControllerWithIdentifier:@"loginview"];
    
    //LoginViewController* loginViewController =
    //[[LoginViewController alloc] init];
    //[[LoginViewController alloc]initWithNibName:@"SCLoginViewController" bundle:nil];
    [topViewController presentModalViewController:loginViewController animated:NO];
}

- (void)showLoggedinView
{
    UIViewController *topViewController = [self.navigationController topViewController];
          
     UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
     
     BaseViewController* baseViewController=[stryBoard instantiateViewControllerWithIdentifier:@"baseview"];
    
    [topViewController presentModalViewController:baseViewController animated:NO];
    
    
}*/

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            NSLog(@"FBSessionStateOpen.");
            /*UIViewController *topViewController =
            [self.navigationController topViewController];
            if ([[topViewController modalViewController]
                 isKindOfClass:[LoginViewController class]]) {
                [topViewController dismissModalViewControllerAnimated:YES];
            }*/
            /*[self.window setRootViewController:self.mainViewController];
            [self.mainViewController setSelectedIndex:0];
            [self.window makeKeyAndVisible];
             */
            [[FBRequest requestForMe] startWithCompletionHandler:
             ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                 if (!error) {
                     NSString* fid = [user objectForKey:@"id"];
                     NSString* funame = [user objectForKey:@"username"];
                     NSLog(@"FBSessionStateOpen: username = %@",funame);
                     NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
                     if([settings objectForKey:@"username"]==nil){
                         [settings setObject:funame forKey:@"username"];
                         [settings setObject:fid forKey:@"userid"];
                     }
                     [settings synchronize];
                     [self registerTheDevice];
                 }
             }];
            UIViewController *topViewController =
            [self.navigationController topViewController];
            if ([[topViewController modalViewController]
                 isKindOfClass:[LoginViewController class]]) {
                [topViewController dismissModalViewControllerAnimated:YES];
            }

        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            NSLog(@"FBSessionStateClosed.");
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            //[FBSession.activeSession close];
            //[FBSession setActiveSession:nil];
            
            [self showLoginView];
            break;
        default:
            NSLog(@"Default FB State.");
            break;
    }
    
    if (error) {
        NSLog(@"FB State error.");

        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}


//pass fb id to backend ?
- (void)openSession
{
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

//notifications
-(void)notificarePushLib:(NotificarePushLib *)library didRegisterForWebsocketsNotifications:(NSString *)token{
    
    NSLog(@"did register for notifications");
    NSLog(@"Device token is %@",token);

    [self setTheDeviceUUID:token];
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    if([settings objectForKey:@"username"]!=nil){
        [self registerTheDevice];
    }
    
    //If you don't identify users you can just use this
    //[[NotificarePushLib shared] registerDeviceForWebsockets:token];
    
    //If you only identify users by ID you can use this (this enables you to have more devices in one user profile)
    //[[NotificarePushLib shared] registerDeviceForWebsockets:token withUserID:@"[SOME_ID]" withUsername:@"[SOME_NAME]"];
    
    //If you identify users by ID and Name you can just use this (this enables you to have more devices in one user profile)
    //[[NotificarePushLib shared] registerDeviceForWebsockets:token withUserID:@"[SOME_ID]" withUsername:@"[SOME_NAME]"];
}

-(void)notificarePushLib:(NotificarePushLib *)library didFailToRegisterWebsocketNotifications:(NSError *)error{
    //You might want to reconnect again
    [[NotificarePushLib shared] registerForWebsockets];
}
-(void)notificarePushLib:(NotificarePushLib *)library didCloseWebsocketConnection:(NSString *)reason{
    //You might want to reconnect again
    [[NotificarePushLib shared] registerForWebsockets];
}

-(void)notificarePushLib:(NotificarePushLib *)library didReceiveWebsocketNotification:(NSDictionary *)info{
    
    //NSLog(@"did receive notification");   
    [[NotificarePushLib shared] openNotification:info];
    
    [[NotificarePushLib shared] getNotification:[info objectForKey:@"username"] completionHandler:^(NSDictionary *info) {
        //NSLog(@"%@",info);
    } errorHandler:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)notificarePushLib:(NotificarePushLib *)library willOpenNotification:(Notification *)notification{
    NSLog(@"%@",notification);
}

- (void)notificarePushLib:(NotificarePushLib *)library didOpenNotification:(Notification *)notification{
    NSLog(@"%@",notification);
}

- (void)notificarePushLib:(NotificarePushLib *)library didCloseNotification:(Notification *)notification{
    NSLog(@"%@",notification);
}

- (void)notificarePushLib:(NotificarePushLib *)library didFailToOpenNotification:(Notification *)notification{
    NSLog(@"%@",notification);
}

-(void)registerTheDevice{
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    [[NotificarePushLib shared] registerDeviceForWebsockets:[self theDeviceUUID] withUserID:[settings objectForKey:@"userid"] withUsername:[settings objectForKey:@"username"]];
    
    //You could start the location update manager if
    //you tracking your user loacation, we use significant location change
    //to track your users
    //[[NotificarePushLib shared] startLocationUpdates];
    
    //You can also force a location update your self
    //[[NotificarePushLib shared] updateLocation:[self theDeviceUUID] withLatitude:1.0 andLongitude:1.0];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SnatterN" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SnatterN.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
