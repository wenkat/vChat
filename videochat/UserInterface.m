//
//  UserInterface.m
//  videochat
//
//  Created by Venkateswaran Shankar on 01/12/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import "UserInterface.h"
#import "ios_utils.h"

@implementation UserInterface

-(bool) login
{
    user_id = [ios_utils getUUID];
    NSString* url = [NSString stringWithFormat:vLoginUrl, user_id];
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: url]];
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([content isEqualToString:@"OK"])
    {
        NSLog(@"Login Successful. User ID: %@", user_id);
        return true;
    }
    return false;
}

-(NSString *) getUserID
{
    return user_id;
}

-(NSString *) getPartnerID
{
    NSString* url = [NSString stringWithFormat:vGetPartnertUrl, user_id];
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: url]];
    NSString *random_partner_id = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Partner Found!!! User ID: %@", random_partner_id);
    return random_partner_id;
}

-(void) logout
{    
    NSString* url = [NSString stringWithFormat:vLogoutUrl, user_id];
    NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString: url]];
    NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Logout. User ID: %@", user_id);
    NSLog(@"Logout. Content: %@", content);
    
}
@end
