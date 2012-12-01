//
//  ios_utils.m
//  videochat
//
//  Created by Venkateswaran Shankar on 01/12/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import "ios_utils.h"

@implementation ios_utils


+(NSString *) getUUID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *UUID = @"";

    if (![defaults valueForKey:@"UUID"])
    {
        CFUUIDRef UUIDRef = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef UUIDSRef = CFUUIDCreateString(kCFAllocatorDefault, UUIDRef);
        UUID = [NSString stringWithFormat:@"%@", UUIDSRef];
    
        [defaults setObject:UUID forKey:@"UUID"];
    }
    else {
        UUID = [defaults valueForKey:@"UUID"];
    }
    
    return UUID;
}

+ (void)showAlert:(NSString*)string {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message from video session"
                                                    message:string
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end