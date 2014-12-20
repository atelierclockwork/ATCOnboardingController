//
//  ATCOnboardingAuthItem.h
//  ATCOnboardingController
//
//  Created by Michael Skiba on 12/19/14.
//  Copyright (c) 2014 Michael Skiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATCOnboardingAuth.h"
#import "ATCOnboardingViewProtocol.h"
@interface ATCOnboardingAuthItem : NSObject
@property (nonatomic, readonly) UIViewController<ATCOnboardingView> *view;
@property (nonatomic, readonly) ATCOnboardingAuth authType;
-(instancetype)initWithView:(UIViewController<ATCOnboardingView> *)view AuthType:(ATCOnboardingAuth)authType requiredAuth:(Boolean)required;
@end
