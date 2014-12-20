//
//  ATCAuthViewController.h
//  ATCOnboardingController
//
//  Created by Michael Skiba on 12/19/14.
//  Copyright (c) 2014 Michael Skiba. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ATCOnboardingController;

@interface ATCAuthViewController : UIViewController<ATCOnboardingView>
@property (nonatomic, weak)ATCOnboardingSession *onboardingSessionDelegate;
@end
