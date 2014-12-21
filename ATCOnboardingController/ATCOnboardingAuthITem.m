//
//  ATCOnboardingAuthItem.m
//  ATCOnboardingController
//
//  Created by Michael Skiba on 12/19/14.
//  Copyright (c) 2014 Michael Skiba. All rights reserved.
//

#import "ATCOnboardingAuthItem.h"
@interface ATCOnboardingAuthItem()
@property (nonatomic) Boolean authRequired;
@property (nonatomic) ATCOnboardingAuth authType;
@property (nonatomic, strong) UIViewController<ATCOnboardingView> *view;
@end

@implementation ATCOnboardingAuthItem
-(instancetype)initWithView:(UIViewController<ATCOnboardingView>*)view AuthType:(ATCOnboardingAuth)authType{
    self = [super init];
    if (self){
        _authType = authType;
        _view = view;
    }
    return self;
}

-(instancetype)initWithView:(UIViewController<ATCOnboardingView> *)view{
    return [self initWithView:view AuthType:ATCONboardingAuthNone];
}
@end
