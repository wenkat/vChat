//
//  UserInterface.h
//  videochat
//
//  Created by Venkateswaran Shankar on 01/12/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString* const vLoginUrl = @"http://quiet-peak-9535.herokuapp.com/login?user_id=%@";
static NSString* const vLogoutUrl = @"http://quiet-peak-9535.herokuapp.com/logout?user_id=%@";
static NSString* const vGetPartnertUrl = @"http://quiet-peak-9535.herokuapp.com/get_random_online_user?user_id=%@";

@interface UserInterface : NSObject
{
    NSString *user_id;
}
-(bool) login;
-(NSString *) getUserID;
-(NSString *) getPartnerID;
-(void) logout;

@end
