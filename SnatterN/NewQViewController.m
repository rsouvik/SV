//
//  NewQViewController.m
//  SnatterN
//
//  Created by Souvik Ray on 12/19/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import "NewQViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SnAPI.h"
#import "SnSyncEngine.h"
#import "SnCoreDataController.h"

@interface NewQViewController ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObject *question;

@end

@implementation NewQViewController

@synthesize questionText;
@synthesize delegate;

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
    [questionText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
    [self.delegate NewQViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender
{
    [self newpostQ];
	[self.delegate NewQViewControllerDidSave:self];
}

- (void) newpostQ {
    
    [self.question setValue:self.questionText.text forKey:@"questxt"];
    [self.question setValue:[NSNumber numberWithInt:SDObjectCreated] forKey:@"syncStatus"];
    
    [self.managedObjectContext performBlockAndWait:^{
        NSError *error = nil;
        BOOL saved = [self.managedObjectContext save:&error];
        if (!saved) {
            // do some real error handling
            NSLog(@"Could not save question due to %@", error);
        }
        //Save the context
        [[SnCoreDataController sharedInstance] saveMasterContext];
    }];
    
    //completion block check?
}

//post Q
//goes into Question DB
//curl -d "d=Snatter12" "localhost:8000/q?uid=100006362773273&t=A&pt=foo&at=e&qid=1"
- (void)postQ {
    
    NSLog(@"Question Posted:%@",self.questionText.text);
    //create unique postid
    NSUUID  *UUID = [NSUUID UUID];
    NSString* stringUUID = [UUID UUIDString];
    
    //send to DB
    /*if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 NSString* command = @"userpost";
                 NSString* fid = [user objectForKey:@"id"];
                 NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: command, @"command", fid, @"fid", self.questionText.text, @"query", stringUUID, @"postid", nil];
                 
                 [[API sharedInstance] commandWithParams:params onCompletion:^(NSDictionary *json) {
                     //result returned
                     NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
                     if ([json objectForKey:@"error"]==nil && [res objectForKey:@"QUESTXT"]) {
                         NSLog(@"Success posting");
                     } else {
                         //error
                         NSLog(@"Error posting.");
                     }
                 }];
             }
         }];
    }*/
    
    //GET call to nginx
    /*NSString* params = @"uid=100006362773273&t=Q&pt=foo&at=e&qid=1&d=Snatter111";
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 //NSString* fid = [user objectForKey:@"id"];
                 //NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: command, @"command", fid, @"fid", myTextField.text, @"query", stringUUID, @"postid", nil];
                 [[API sharedInstance] commandGet:params onCompletion:^(NSDictionary *json) {
                     //result returned
                     NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
                     if ([json objectForKey:@"error"]==nil && [res objectForKey:@"QUESTXT"]) {
                         NSLog(@"Success posting to Go");
                     } else {
                         //error
                         NSLog(@"Error posting to Go.");
                     }
                 }];
             }
         }];
    }*/
    
    //post to nginx
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             if (!error) {
                 NSString* data = self.questionText.text;
                 NSString* fid = [user objectForKey:@"id"];
                 NSString* type = @"Q";
                 //NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: data, @"d", fid, @"uid", type, @"t", stringUUID, @"qid", @"foo", @"pt", @"e", @"at", nil];
                 NSMutableDictionary* params =[NSMutableDictionary dictionaryWithObjectsAndKeys: data, @"d", nil];
                 [[API sharedInstance] commandPost:params onCompletion:^(NSDictionary *json) {
                     //result returned
                     NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
                     if ([json objectForKey:@"error"]==nil && [res objectForKey:@"QUESTXT"]) {
                         NSLog(@"Success posting to go server");
                     } else {
                         //error
                         NSLog(@"Error posting.");
                     }
                 }];
             }
         }];
    }
    
}

@end
