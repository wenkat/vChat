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
- (void)doConnect;
- (void)doPublish;
- (void)showAlert:(NSString*)string;
@end
