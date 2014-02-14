//
//  SplashViewController.m
//  SnatterN
//
//  Created by Souvik Ray on 12/13/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Do any additional setup after loading the view.
    NSTimer *myTimer = [NSTimer timerWithTimeInterval:3.0
                                               target:self
                                             selector:@selector(timerFiredMethod:)
                                             userInfo:nil
                                              repeats: NO];
    
    [[NSRunLoop mainRunLoop] addTimer: myTimer
                              forMode: NSDefaultRunLoopMode];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSTimer *myTimer = [NSTimer timerWithTimeInterval:3.0
                                               target:self
                                             selector:@selector(timerFiredMethod:)
                                             userInfo:nil
                                              repeats: NO];
    
    [[NSRunLoop mainRunLoop] addTimer: myTimer
                              forMode: NSDefaultRunLoopMode];
}

- (void)timerFiredMethod:(NSTimer *)timer
{
    // Whatever the segue is called to your second view controller. Don't forget to set it in your storyboard ;)
    [self performSegueWithIdentifier:@"seguetotabbedview" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
