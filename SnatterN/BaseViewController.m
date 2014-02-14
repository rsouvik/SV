//
//  BaseViewController.m
//  SnatterN
//
//  Created by Souvik Ray on 12/11/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*if (FBSession.activeSession.isOpen) {
        //[self registerUser];
        [self refreshPosts];
        //[self populateUserDetails];
        //self.userProfileImage.hidden = NO;
    } else {
        //self.userProfileImage.hidden = YES;
    }*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
