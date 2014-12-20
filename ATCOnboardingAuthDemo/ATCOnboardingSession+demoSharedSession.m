//
//  ATCOnboardingSession+demoSharedSession.m
//  ATCOnboardingController
//
//  Created by Michael Skiba on 12/19/14.
//  Copyright (c) 2014 Michael Skiba. All rights reserved.
//

#import "ATCOnboardingSession+demoSharedSession.h"

@implementation ATCOnboardingSession (demoSharedSession)
+(ATCOnboardingSession *)sharedSession{
    static ATCOnboardingSession *demoSharedSession;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
    return demoSharedSession;
}
@end
