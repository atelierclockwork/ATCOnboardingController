//
//  ATCOnboardingViewProtocol.h
//  ATCOnboardingController
//
//  Created by Michael Skiba on 12/19/14.
//  Copyright (c) 2014 Michael Skiba. All rights reserved.
//

#ifndef ATCOnboardingController_ATCOnboardingViewProtocol_h
#define ATCOnboardingController_ATCOnboardingViewProtocol_h

@class ATCOnboardingSession;

@protocol ATCOnboardingView
@property (nonatomic, weak)ATCOnboardingSession *onboardingSessionDelegate;
@end

#endif
