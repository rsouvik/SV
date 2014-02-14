//
//  NewQViewController.h
//  SnatterN
//
//  Created by Souvik Ray on 12/19/13.
//  Copyright (c) 2013 com.snatter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewQViewController;

@protocol NewQViewControllerDelegate <NSObject>
- (void)NewQViewControllerDidCancel:
(NewQViewController *)controller;
- (void)NewQViewControllerDidSave:
(NewQViewController *)controller;
@end

@interface NewQViewController : UIViewController
@property (nonatomic, weak) id <NewQViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UITextView *questionText;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
