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
-(instancetype)initWithAuthTypes:(NSArray *)authTypes completionView:(UIViewController<ATCOnboardingView> *)completionView navigationController:(UINavigationController *)navigationController;
-(instancetype)initWithAuthTypes:(NSArray *)authTypes completionView:(UIViewController *)completionView;
+(BOOL)needsAuthorization:(ATCOnboardingAuth) authType;
+(BOOL)checkAuthAllowed:(ATCOnboardingAuth) authType;
-(UIViewController*)presentationForView:(UIViewController *)presentingView style:(UIModalPresentationStyle)style;
-(void)nextItem;
-(void)nextItemWithAuth;
@end