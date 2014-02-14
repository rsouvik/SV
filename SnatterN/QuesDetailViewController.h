//
//  QuesDetailViewController.h
//  SnatterN
//
//  Created by Souvik Ray on 12/17/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuesDetailViewController : UIViewController

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) IBOutlet UILabel *questionText;

@end
