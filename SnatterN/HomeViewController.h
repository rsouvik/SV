//
//  HomeViewController.h
//  SnatterN
//
//  Created by Souvik Ray on 12/8/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "JSONBuilder.h"

@interface HomeViewController : UITableViewController<FBUserSettingsDelegate, UIAlertViewDelegate,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *questions;

@end
