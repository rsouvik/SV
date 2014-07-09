//
//  HomeViewController.m
//  SnatterN
//
//  Created by Souvik Ray on 12/8/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import "HomeViewController.h"
#import "QuesDetailViewController.h"
#import "Question.h"
#import "SnAPI.h"
#import "SnAppDelegate.h"
#import "SVProgressHUD.h"
#import "Post.h"

@interface HomeViewController ()< UITableViewDataSource,
UIImagePickerControllerDelegate,
FBFriendPickerDelegate,
UINavigationControllerDelegate,
FBPlacePickerDelegate,
CLLocationManagerDelegate,
UIActionSheetDelegate,
UITextFieldDelegate,
UITableViewDelegate>

@end

@implementation HomeViewController

@synthesize questions;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    questions = [NSMutableArray arrayWithCapacity:20];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    NSLog(@"View did load.");

    /*questions = [NSMutableArray arrayWithCapacity:20];

    Question *ques = [[Question alloc] init];
	ques.text = @"Bill Evans";
	[self.questions addObject:ques];
    ques = [[Question alloc] init];
	ques.text = @"Bill Evans1";
	[self.questions addObject:ques];
    
    */
    
    /*dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
        if (FBSession.activeSession.isOpen) {
            //[self registerUser];
            [self refreshPosts];
            //[self populateUserDetails];
            //self.userProfileImage.hidden = NO;
        } else {
            //self.userProfileImage.hidden = YES;
        }
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    });*/

    
    self.title = @"Snatter";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Logout"
                                              style:UIBarButtonItemStyleBordered
                                              target:self
                                              action:@selector(logoutButtonWasPressed:)];
    
    
    //[self performSelectorInBackground:@selector(initilizeHomeViewWithData) withObject:nil];
}

-(void)initilizeHomeViewWithData {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    //if (FBSession.activeSession.isOpen) {
        //[self registerUser];
        [self refreshPosts];
        //[self populateUserDetails];
        //self.userProfileImage.hidden = NO;
    //} else {
        //self.userProfileImage.hidden = YES;
    //}
    
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
}

- (void)viewDidUnload {
    [super viewDidUnload];
        
    // Release any retained subviews of the main view.
    self.questions=nil;
}

-(void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"View will appear.");

    [super viewWillAppear:animated];
    
    //clean
    [self.questions removeAllObjects];
    //[self performSelectorInBackground:@selector(initilizeHomeViewWithData) withObject:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
        if (FBSession.activeSession.isOpen) {
            //[self registerUser];
            //refresh from DB
            [self refreshPostsNew];
            //[self populateUserDetails];
            //self.userProfileImage.hidden = NO;
        } else {
            //self.userProfileImage.hidden = YES;
        }
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    });
}

//Post processing
- (void) viewDidAppear:(BOOL)animated {
    //if (FBSession.activeSession.isOpen) {
        //[self.locationManager startUpdatingLocation];
    //}
    [super viewDidAppear:animated];
    NSLog(@"View did appear.");

    //[self refreshPosts];

    /*self.tableView.dataSource=self;
    self.tableView.delegate=self;
    Question *ques = [[Question alloc] init];
	ques.text = @"Bill Evans";
	[self.questions addObject:ques];
    ques = [[Question alloc] init];
	ques.text = @"Bill Evans1";
	[self.questions addObject:ques];*/
    //[self.tableView reloadData];
    //NSLog(@"View did app.");

}

- (void) refreshPosts {
    
    if (FBSession.activeSession.isOpen) {
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 NSLog(@"Refresh posts.");
                 NSString* command = @"streamposts";
                 //we need to send the fb username
                 NSString* fid = [user objectForKey:@"id"];
                 NSString* funame = [user objectForKey:user.name];
                 NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: command, @"command", fid, @"fid", nil];
                 
                 //make the call to the web API
                 [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
                     NSError *e = nil;
                     //NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: [json objectForKey:@"result"] options: NSJSONReadingMutableContainers error: &e];
                     NSMutableArray *jsonArray = [NSMutableArray arrayWithArray:[json objectForKey:@"result"]]; 
                     
                     NSMutableArray *quesArray = [jsonArray valueForKey:@"QUESTXT"];
                     //self.questions=quesArray;
                     [self loadPosts:quesArray];
                     
                 }];
             }
         }];
    }
}

- (void) refreshPostsNew {
    
    if (FBSession.activeSession.isOpen) {
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 NSLog(@"Refresh posts.");
                 NSString* command = @"streamposts";
                 //we need to send the fb username
                 NSString* fid = [user objectForKey:@"id"];
                 NSString* funame = [user objectForKey:user.name];
                 NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: command, @"command", fid, @"fid", nil];
                 
                 //make the call to the web API
                 [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
                     NSError *e = nil;
                     //NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: [json objectForKey:@"result"] options: NSJSONReadingMutableContainers error: &e];
                     //NSMutableArray *jsonArray = [NSMutableArray arrayWithArray:[json objectForKey:@"result"]];
                     
                     //NSMutableArray *quesArray = [jsonArray valueForKey:@"QUESTXT"];
                     NSArray *quesArray = [JSONBuilder postsFromJSON:json];
                     //self.questions=quesArray;
                     [self loadPostsNew:quesArray];
                     
                 }];
             }
         }];
    }
}

- (void)loadPosts:(NSArray*) stream {
    //for (UIView* view in listView.subviews) {
      //  [view removeFromSuperview];
    //}
    //const CGFloat width = 250;
    //const CGFloat height = 30;
    //const CGFloat margin = 0;
    //CGFloat y = 0;
    
    //questions = [NSMutableArray arrayWithCapacity:20];
    
    for (int i=0;i<[stream count];i++) {
        NSString* post = [stream objectAtIndex:i];
        Question *ques = [[Question alloc] init];
        ques.text=post;
        [self.questions addObject:ques];
    }
    [self.tableView reloadData];
}

- (void)loadPostsNew:(NSArray*) stream {
    
    for (int i=0;i<[stream count];i++) {
        Post* post = [stream objectAtIndex:i];
        Question *ques = [[Question alloc] init];
        ques.text=post.QUESTXT;
        [self.questions addObject:ques];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logoutButtonWasPressed:(id)sender {
    if (FBSession.activeSession.isOpen) {
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession.activeSession close];
    [FBSession setActiveSession:nil];
    
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie* cookie in
         [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [cookies deleteCookie:cookie];
    }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"count=%lu",(unsigned long)[self.questions count]);
    return [self.questions count];
    //return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"Question"];
	Question *player = [self.questions objectAtIndex:indexPath.row];
	cell.textLabel.text = player.text;
	//cell.detailTextLabel.text = player.game;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showQuestionDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        QuesDetailViewController *destViewController = segue.destinationViewController;
        Question *ques = [self.questions objectAtIndex:indexPath.row];
        NSString *q = ques.text;
        //destViewController.question = [self.questions objectAtIndex:indexPath.row];
        destViewController.question = q;
    }
}

@end
