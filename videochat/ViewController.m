//
//  ViewController.m
//  videochat
//
//  Created by Venkateswaran Shankar on 04/06/12.
//  Copyright (c) 2012 wenkat.s@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "VideoSession.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewController {
    OTSession* _session;
    OTPublisher* _publisher;
    OTSubscriber* _subscriber;
    VideoSession* _vSession;
}
@synthesize stopWatchLabel = _stopWatchLabel;
@synthesize actionToolBar = _actionToolBar;
@synthesize chatComplete = _chatComplete;

static NSString* const kApiKey = @"15360982";
static bool subscribeToSelf = YES; // Change to NO if you want to subscribe to streams other than your own.

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _vSession = [VideoSession alloc];
    [_vSession initialize:self];
    _session = [[OTSession alloc] initWithSessionId: [_vSession getSessionId]
                                           delegate:self];
    [self doConnect];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return NO;
    } else {
        return YES;
    }
}

- (void)updateSubscriber {
    for (NSString* streamId in _session.streams) {
        OTStream* stream = [_session.streams valueForKey:streamId];
        if (![stream.connection.connectionId isEqualToString: _session.connection.connectionId]) {
            _subscriber = [[OTSubscriber alloc] initWithStream:stream delegate:self];
            break;
        }
    }
}

#pragma mark - OpenTok methods

- (void)doConnect 
{
    [_session connectWithApiKey:kApiKey token: [_vSession getSessionToken]];
}

- (void)doPublish
{
    
    int toolbarHelight = self.actionToolBar.layer.frame.size.height;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height - toolbarHelight;
    double widgetHeight = screenHeight/4;
    double widgetWidth = screenWidth/4;
    
    _publisher = [[OTPublisher alloc] initWithDelegate:self];
    [_publisher setName:[[UIDevice currentDevice] name]];
    [_session publish:_publisher];
    [self.view addSubview:_publisher.view];
    [_publisher.view setFrame:CGRectMake(screenWidth - widgetWidth, screenHeight - widgetHeight - (toolbarHelight / 2), widgetWidth, widgetHeight)];
    
    _publisher.view.layer.masksToBounds = NO;
    _publisher.view.layer.cornerRadius = 10; // if you like rounded corners
    _publisher.view.layer.shadowOffset = CGSizeMake(-15, 20);
    _publisher.view.layer.shadowRadius = 10;
    _publisher.view.layer.shadowOpacity = 0.8;
    _publisher.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:_publisher.view.bounds].CGPath;
}

- (void)sessionDidConnect:(OTSession*)session
{
    NSLog(@"sessionDidConnect (%@)", session.sessionId);
    [self doPublish];
}

- (void)sessionDidDisconnect:(OTSession*)session
{
    NSString* alertMessage = [NSString stringWithFormat:@"Session disconnected: (%@)", session.sessionId];
    NSLog(@"sessionDidDisconnect (%@)", alertMessage);
    [self showAlert:alertMessage];
}


- (void)session:(OTSession*)mySession didReceiveStream:(OTStream*)stream
{
    NSLog(@"session didReceiveStream (%@)", stream.streamId);
    
    // See the declaration of subscribeToSelf above.
    if ( (subscribeToSelf && [stream.connection.connectionId isEqualToString: _session.connection.connectionId])
           ||
         (!subscribeToSelf && ![stream.connection.connectionId isEqualToString: _session.connection.connectionId])
       ) {
        if (!_subscriber) {
            _subscriber = [[OTSubscriber alloc] initWithStream:stream delegate:self];
        }
    }
}

- (void)session:(OTSession*)session didDropStream:(OTStream*)stream{
    NSLog(@"session didDropStream (%@)", stream.streamId);
    NSLog(@"_subscriber.stream.streamId (%@)", _subscriber.stream.streamId);
    if (!subscribeToSelf
        && _subscriber
        && [_subscriber.stream.streamId isEqualToString: stream.streamId])
    {
        _subscriber = nil;
        [self updateSubscriber];
    }
}

- (void)subscriberDidConnectToStream:(OTSubscriber*)subscriber
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    NSLog(@"subscriberDidConnectToStream (%@)", subscriber.stream.connection.connectionId);
    [subscriber.view setFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.view insertSubview:subscriber.view atIndex:0];
}

- (void)publisher:(OTPublisher*)publisher didFailWithError:(OTError*) error {
    NSLog(@"publisher didFailWithError %@", error);
    [self showAlert:[NSString stringWithFormat:@"There was an error publishing."]];
}

- (void)subscriber:(OTSubscriber*)subscriber didFailWithError:(OTError*)error
{
    NSLog(@"subscriber %@ didFailWithError %@", subscriber.stream.streamId, error);
    [self showAlert:[NSString stringWithFormat:@"There was an error subscribing to stream %@", subscriber.stream.streamId]];
}

- (void)session:(OTSession*)session didFailWithError:(OTError*)error {
    NSLog(@"sessionDidFail");
    [self showAlert:[NSString stringWithFormat:@"There was an error connecting to session %@", session.sessionId]];
}


- (void)showAlert:(NSString*)string {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message from video session"
                                                    message:string
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidUnload {
    [self setStopWatchLabel:nil];
    [self setActionToolBar:nil];
    [self setChatComplete:nil];
    [super viewDidUnload];
}
@end

