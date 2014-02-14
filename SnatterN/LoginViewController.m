//
//  LoginViewController.m
//  SnatterN
//
//  Created by Souvik Ray on 12/10/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import "LoginViewController.h"
#import "SnAppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
- (IBAction)performLogIn:(id)sender {
    //[self.spinner startAnimating];
    
    SnAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
    NSLog(@"Success Login here.");
    //[self registerUser]; //Added Souvik
}

@end
