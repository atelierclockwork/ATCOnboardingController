//
//  ATCAuthViewController.m
//  ATCOnboardingController
//
//  Created by Michael Skiba on 12/19/14.
//  Copyright (c) 2014 Michael Skiba. All rights reserved.
//

#import "ATCAuthViewController.h"
#import "ATCOnboardingSession+demoSharedSession.m"
@interface ATCAuthViewController ()
- (IBAction)checkAuth:(id)sender;
- (IBAction)skipAuth:(id)sender;
@end

@implementation ATCAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)checkAuth:(id)sender {
    [self.onboardingSessionDelegate nextItemWithAuth];
}

- (IBAction)skipAuth:(id)sender{
    [self.onboardingSessionDelegate nextItem];
}
@end
