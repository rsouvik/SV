//
//  QuesViewController.m
//  SnatterN
//
//  Created by Souvik Ray on 12/19/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import "QuesViewController.h"

@interface QuesViewController ()

@end

@implementation QuesViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSegueWithIdentifier:@"seguetoques" sender:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NewQViewControllerDelegate

- (void)NewQViewControllerDidCancel:
(NewQViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)NewQViewControllerDidSave:
(NewQViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
    [self.tabBarController setSelectedIndex:0];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"seguetoques"])
	{
		UINavigationController *navigationController =
        segue.destinationViewController;
		NewQViewController
        *newQuesViewController =
        [[navigationController viewControllers]
         objectAtIndex:0];
		newQuesViewController.delegate = self;
	}
}

@end
