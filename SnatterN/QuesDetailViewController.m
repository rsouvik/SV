//
//  QuesDetailViewController.m
//  SnatterN
//
//  Created by Souvik Ray on 12/17/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import "QuesDetailViewController.h"
#import "SVProgressHUD.h"

@interface QuesDetailViewController ()

@end

@implementation QuesDetailViewController

@synthesize question;
@synthesize questionText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
	// Do any additional setup after loading the view.
    questionText.text=question;
    [SVProgressHUD dismiss];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
