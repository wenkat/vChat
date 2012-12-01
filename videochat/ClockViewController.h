//
//  ClockViewController.h
//  videochat
//
//  Created by Venkateswaran Shankar on 22/07/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ViewController.h"

@interface ClockViewController : UIViewController
{
	IBOutlet UILabel* clockLabel;
	NSTimer *myTicker;
    NSDate *startDate;
    NSDate *endDate;
}

/* New Methods */
- (void) runTimer:(ViewController *)frame;
- (void)showActivity;
- (void)updateTimer;

@end
