//
//  NotifViewController.h
//  SnatterN
//
//  Created by Souvik Ray on 12/30/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotifViewController : UITableViewController<UIAlertViewDelegate,UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *notifs;

@end
