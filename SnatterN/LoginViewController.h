//
//  LoginViewController.h
//  SnatterN
//
//  Created by Souvik Ray on 12/10/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController : UIViewController<FBLoginViewDelegate>

- (IBAction)performLogIn:(id)sender;

@end
