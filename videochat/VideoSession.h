//
//  VideoSession.h
//  videochat
//
//  Created by Venkateswaran Shankar on 07/07/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ViewController.h"
#import "UserInterface.h"

//static NSString* const vSessionUrl = @"http://morning-window-9520.herokuapp.com/";
static NSString* const vGetSessionUrl = @"http://quiet-peak-9535.herokuapp.com/get_new_session?user_id=%@&partner_id=%@";
static NSString* const vGetTokenUrl = @"http://quiet-peak-9535.herokuapp.com/get_new_token?user_id=%@&partner_id=%@";


@interface VideoSession : NSObject
{
    NSString *vToken;
    NSString *vSessionId;
    UserInterface *me;
    NSString *user_id;
    NSString *partner_id;
    ViewController *viewController;
}

- (void) initialize:(ViewController *) frame;
-(NSString *) getSessionId;
-(NSString *) getSessionToken;
-(void) deinitialize;
-(void) StartTimerTick;

@end
