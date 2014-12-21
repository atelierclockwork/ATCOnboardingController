//
//  ATCOnboardingSession.h
//  ATCOnboardingController
//
//  Created by Michael Skiba on 12/19/14.
//  Copyright (c) 2014 Michael Skiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATCOnboardingAuth.h"
#import "ATCOnboardingViewProtocol.h"

@class ATCOnboardingAuthItem;

@interface ATCOnboardingSession : NSObject
-(instancetype)initWithAuthTypes:(NSArray *)authTypes;
-(instancetype)initWithAuthTypes:(NSArray *)authTypes navigationController:(UINavigationController *)navigationController;
@property (nonatomic, readonly)UINavigationController *navigationController;
+(BOOL)needsAuthorization:(ATCOnboardingAuth) authType;
+(BOOL)checkAuthAllowed:(ATCOnboardingAuth) authType;
-(void)nextItem;
-(void)nextItemWithAuth;
@end