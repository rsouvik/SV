//
//  BaseViewController.h
//  SnatterN
//
//  Created by Souvik Ray on 12/11/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>


@interface BaseViewController : UITabBarController<FBUserSettingsDelegate, UIAlertViewDelegate,UITextFieldDelegate>

@end
