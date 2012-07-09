//
//  VideoSession.h
//  videochat
//
//  Created by Venkateswaran Shankar on 07/07/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const vSessionUrl = @"http://morning-window-9520.herokuapp.com/";

@interface VideoSession : NSObject
{
    NSString *vToken;
    NSString *vSessionId;
}

- (void) initialize;
-(NSString *) getSessionId;
-(NSString *) getSessionToken;

@end
