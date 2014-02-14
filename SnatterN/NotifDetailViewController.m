//
//  NotifDetailViewController.m
//  SnatterN
//
//  Created by Souvik Ray on 1/3/14.
//  Copyright (c) 2014 com.snatter. All rights reserved.
//

#import "NotifDetailViewController.h"

@interface NotifDetailViewController ()

@end

@implementation NotifDetailViewController

@synthesize questionText;
@synthesize answerText;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
