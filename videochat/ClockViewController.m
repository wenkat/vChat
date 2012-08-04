//
//  ClockViewController.m
//  videochat
//
//  Created by Venkateswaran Shankar on 22/07/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import "ClockViewController.h"

@implementation ClockViewController

- (void)runTimer:(ViewController *)frame {
    clockLabel = frame.stopWatchLabel;
    //clockLabel.font=[UIFont fontWithName:@"DBLCDTempBlack" size:20.0];
    
    //clockLabel.layer.zPosition = 1;
    //[clockLabel setText:@"test"];
    
    
    // This starts the timer which fires the showActivity
    // method every 0.5 seconds
    startDate = [NSDate date];
    myTicker = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                      target:self
                                                    selector:@selector(updateTimer)
                                                    userInfo:nil
                                                     repeats:YES];
    
}

- (void)updateTimer
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    clockLabel.text = timeString;
}

// This method is run every 0.5 seconds by the timer created
// in the function runTimer
- (void)showActivity {
    
    NSDateFormatter *formatter =
    [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    
    // This will produce a time that looks like "12:15:00 PM".
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    
    // This sets the label with the updated time.
    [clockLabel setText:[formatter stringFromDate:date]];
    
}

@end
