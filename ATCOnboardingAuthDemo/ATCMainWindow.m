//
//  ATCMainWindow.m
//  ATCOnboardingController
//
//  Created by Michael Skiba on 12/19/14.
//  Copyright (c) 2014 Michael Skiba. All rights reserved.
//

#import "ATCMainWindow.h"
#import "ATCOnboardingSession+demoSharedSession.h"
@interface ATCMainWindow()
@property (nonatomic, strong)ATCOnboardingSession *authSession;
@property (weak, nonatomic) IBOutlet UIButton *addLocationsButton;
@end

@implementation ATCMainWindow
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    NSMutableArray *authTypes = [NSMutableArray new];
    if([ATCOnboardingSession needsAuthorization:ATCOnboardingAuthCamera]){
        UIViewController<ATCOnboardingView> *cameraView =[self.authorizationViews  instantiateViewControllerWithIdentifier:@"cameraAuth"];
        [authTypes addObject: [[ATCOnboardingAuthItem alloc] initWithView:cameraView
                                                                 AuthType:ATCOnboardingAuthCamera
                                                             requiredAuth:YES]];
    }
    if([ATCOnboardingSession needsAuthorization:ATCOnboardingAuthPhotos]){
        UIViewController<ATCOnboardingView> *photosView =[self.authorizationViews  instantiateViewControllerWithIdentifier:@"photoAuth"];
        [authTypes addObject: [[ATCOnboardingAuthItem alloc] initWithView:photosView
                                                                 AuthType:ATCOnboardingAuthPhotos
                                                             requiredAuth:YES]];
    }
    if(authTypes.count > 0){
        UIViewController *completionView = [self.authorizationViews instantiateViewControllerWithIdentifier:@"finishAuth"];
        _authSession =  [[ATCOnboardingSession alloc] initWithAuthTypes:authTypes completionView:completionView];
        [self presentViewController:
         [_authSession presentationForView:self style:UIModalPresentationFormSheet] animated:YES completion:nil];
    }
}

-(UIStoryboard *)authorizationViews{
    return [UIStoryboard storyboardWithName:@"AuthorizationViews" bundle:[NSBundle mainBundle]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _addLocationsButton.hidden = !([ATCOnboardingSession needsAuthorization:ATCOnboardingAuthLocationForeground]);
}
- (IBAction)addLocationServices:(id)sender {
    if([ATCOnboardingSession needsAuthorization:ATCOnboardingAuthLocationForeground]){
        UIViewController<ATCOnboardingView> *locationView =[self.authorizationViews instantiateViewControllerWithIdentifier:@"locationAuth"];
        ATCOnboardingAuthItem *locAuth = [[ATCOnboardingAuthItem alloc] initWithView:locationView
                                                                            AuthType:ATCOnboardingAuthLocationForeground
                                                                        requiredAuth:YES];
        _authSession =  [[ATCOnboardingSession alloc] initWithAuthTypes:@[locAuth] completionView:nil];
        [self presentViewController:
         [_authSession presentationForView:self style:UIModalPresentationFormSheet] animated:YES completion:nil];
    }
    
}

@end
