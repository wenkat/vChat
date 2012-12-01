//
//  vSession.m
//  videochat
//
//  Created by Venkateswaran Shankar on 07/07/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import "VideoSession.h"
#import "ClockViewController.h"
#import "ios_utils.h"

@implementation VideoSession 

-(void) initialize:(ViewController *) frame
{
    viewController = frame;
    me = [UserInterface alloc];
    if (![me login]) {
        [ios_utils showAlert:@"Login Unsuccessfull" ];
    }
    user_id = [me getUserID];
    partner_id = [me getPartnerID];
    
    NSLog(@"User_Id: %@, PartnerId: %@", user_id, partner_id);
    
    NSString* url = [NSString stringWithFormat:vGetSessionUrl, user_id, partner_id];
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: url]];
    vSessionId = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"vSessionId %@", vSessionId);

    url = [NSString stringWithFormat:vGetTokenUrl, user_id, partner_id];
    data = [NSData dataWithContentsOfURL: [NSURL URLWithString: url]];
    vToken = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"vToken %@", vToken);
    
    /*NSArray *listItems = [content componentsSeparatedByString:@"\n"];
    NSLog(@"ListItems Count %d", [listItems count]);
    if ([listItems count] == 3) {
        vSessionId = [listItems objectAtIndex:0];
        vToken = [listItems objectAtIndex:1];
    }*/
    
}

-(void) StartTimerTick
{
    ClockViewController* clock = [ClockViewController alloc];
    [clock runTimer:viewController];
}

-(NSString *) getSessionId
{
    return vSessionId;
}

-(NSString *) getSessionToken
{
    return vToken;
}

-(void) deinitialize
{
    [me logout];
}
@end
