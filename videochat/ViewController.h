//
//  ViewController.h
//  videochat
//
//  Created by Venkateswaran Shankar on 04/06/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Opentok/Opentok.h>

@interface ViewController : UIViewController <OTSessionDelegate, OTSubscriberDelegate, OTPublisherDelegate>

@property (weak, nonatomic) IBOutlet UILabel *activeConnectionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *stopWatchLabel;

@property (weak, nonatomic) IBOutlet UIToolbar *actionToolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *TimeStepper;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Done;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ActionItems;


- (void)doConnect;
- (void)doPublish;
@end
