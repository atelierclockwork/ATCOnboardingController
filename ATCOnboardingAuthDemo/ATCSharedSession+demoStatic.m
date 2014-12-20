//
//  ATCSharedSession+demoStatic.m
//  ATCOnboardingController
//
//  Created by Michael Skiba on 12/19/14.
//  Copyright (c) 2014 Michael Skiba. All rights reserved.
//

#import "ATCSharedSession+demoStatic.h"
@import Foundation;

@implementation ATCSharedSession (demoStatic)
+(ATCSharedSession)sharedSession{
    static ATCSharedSession *session;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    });
    return  session;
}
@end
