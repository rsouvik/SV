//
//  NotifViewController.m
//  SnatterN
//
//  Created by Souvik Ray on 12/30/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import "NotifViewController.h"
#import "NotifDetailViewController.h"
#import "SnAPI.h"
#import "SnAppDelegate.h"
#import "SVProgressHUD.h"
#import "Notif.h"
#import "JSONBuilder.h"

@interface NotifViewController ()

@end

@implementation NotifViewController

@synthesize notifs;


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
    notifs = [NSMutableArray arrayWithCapacity:20];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"View will appear.");
    
    [super viewWillAppear:animated];
    
    //clean
    [self.notifs removeAllObjects];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
        if (FBSession.activeSession.isOpen) {
            //[self registerUser];
            //refresh from DB
            [self refreshNotifs];
            //[self populateUserDetails];
            //self.userProfileImage.hidden = NO;
        } else {
            //self.userProfileImage.hidden = YES;
        }
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    });
}

- (void) refreshNotifs {
    
    if (FBSession.activeSession.isOpen) {
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 NSLog(@"Refresh notifs.");
                 NSString* command = @"streamnotifs";
                 //we need to send the fb username
                 NSString* fid = [user objectForKey:@"id"];
                 NSString* funame = [user objectForKey:user.name];
                 NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: command, @"command", fid, @"fid", nil];
                 
                 //make the call to the web API
                 [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
                     NSArray *notifArray = [JSONBuilder notifsFromJSON:json];
                     [self loadNotifs:notifArray];
                 }];
             }
         }];
    }
}

- (void)loadNotifs:(NSArray*) stream {
    
    for (int i=0;i<[stream count];i++) {
        Notif* notif = [stream objectAtIndex:i];
        [self.notifs addObject:notif];
    }
    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"Notification"];
	Notif *noti = [self.notifs objectAtIndex:indexPath.row];
    if ([noti.type isEqualToString:@"answer"]) {
        cell.textLabel.text = ((NotifAns*)noti).ques;
    }
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
    if ([segue.identifier isEqualToString:@"seguetonotifdetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NotifDetailViewController *destViewController = segue.destinationViewController;
        Notif *noti = [self.notifs objectAtIndex:indexPath.row];
        if ([noti.type isEqualToString:@"answer"]) {
            destViewController.questionText.text=((NotifAns*)noti).ques;
            destViewController.answerText.text=((NotifAns*)noti).ques;
        }
        //NSString *q = ques.text;
        //destViewController.question = [self.questions objectAtIndex:indexPath.row];
        //destViewController.question = q;
    }
}

@end
