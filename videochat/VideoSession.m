//
//  vSession.m
//  videochat
//
//  Created by Venkateswaran Shankar on 07/07/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import "VideoSession.h"
#import "ClockViewController.h"

@implementation VideoSession 

-(void) initialize:(ViewController *) frame
{
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: vSessionUrl]];
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *listItems = [content componentsSeparatedByString:@"\n"];
    NSLog(@"ListItems Count %d", [listItems count]);
    if ([listItems count] == 3) {
        vSessionId = [listItems objectAtIndex:0];
        vToken = [listItems objectAtIndex:1];
    }
    
    
    ClockViewController* clock = [ClockViewController alloc];
    [clock runTimer:frame];
}

-(NSString *) getSessionId
{
    return vSessionId;
}

-(NSString *) getSessionToken
{
    return vToken;
}
@end
