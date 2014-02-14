//
//  SnAppDelegate.h
//  SnatterN
//
//  Created by Souvik Ray on 12/7/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "NotificarePushLib.h"

@class HomeViewController;
@class LoginViewController;
@class BaseViewController;
@class SplashViewController;

@interface SnAppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate,NotificarePushLibDelegate>
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) SplashViewController *mainViewController;
//@property (strong, nonatomic) BaseViewController *mainViewController;
@property (strong, nonatomic) LoginViewController* loginViewController;
@property (strong, nonatomic) BaseViewController* baseViewController;

@property BOOL isNavigating;

- (void)resetMainViewController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSData * theDeviceToken;
@property (strong, nonatomic) NSString * theDeviceUUID;

- (void)openSession;

@end
