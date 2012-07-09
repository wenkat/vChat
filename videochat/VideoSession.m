//
//  vSession.m
//  videochat
//
//  Created by Venkateswaran Shankar on 07/07/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import "VideoSession.h"
@implementation VideoSession 

-(void) initialize
{
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: vSessionUrl]];
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *listItems = [content componentsSeparatedByString:@"\nT1=="];
    NSLog(@"ListItems Count %d", [listItems count]);
    if ([listItems count] == 2) {
        vSessionId = [listItems objectAtIndex:0];
        vToken = [listItems objectAtIndex:1];
    }
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
