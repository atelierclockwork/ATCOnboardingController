//
//  ATCOnboardingSession.m
//  ATCOnboardingController
//
//  Created by Michael Skiba on 12/19/14.
//  Copyright (c) 2014 Michael Skiba. All rights reserved.
//

#import "ATCOnboardingSession.h"
#import "ATCOnboardingAuthItem.h"
#import "ATCOnboardingViewProtocol.h"

@import AVFoundation;
@import AssetsLibrary;
@import Photos;
@import CoreLocation;

@interface ATCOnboardingSession()<CLLocationManagerDelegate, UIAdaptivePresentationControllerDelegate>
@property(nonatomic, strong)NSArray *authTypes;
@property(nonatomic, strong)UIViewController<ATCOnboardingView> *completionView;
@property(nonatomic, strong)UINavigationController *navigationController;
@property(nonatomic)NSUInteger currentIndex;
-(UIViewController<ATCOnboardingView> *)currentView;
-(ATCOnboardingAuthItem *)authItemAtIndex:(NSUInteger)index;
@property (nonatomic, strong)CLLocationManager *manager;
@property (nonatomic, strong)UIPresentationController *presenter;
@property (nonatomic) UIModalPresentationStyle modalStyle;
@end

@implementation ATCOnboardingSession
static ATCOnboardingSession *_sharedSession;

-(instancetype)initWithAuthTypes:(NSArray *)authTypes completionView:(UIViewController<ATCOnboardingView> *)completionView navigationController:(UINavigationController *)navigationController{
    self = [super init];
    if(self){
        _authTypes = authTypes;
        for(ATCOnboardingAuthItem *item in _authTypes){
            item.view.onboardingSessionDelegate = self;
        }
        _completionView = completionView;
        _completionView.onboardingSessionDelegate = self;
        _navigationController = navigationController;
    }
    return self;
}

-(instancetype)initWithAuthTypes:(NSArray *)authTypes completionView:(UIViewController<ATCOnboardingView> *)completionView{
    UINavigationController *defaultNavigation = [UINavigationController new];
    [defaultNavigation setNavigationBarHidden:YES];
    return [self initWithAuthTypes:authTypes completionView:completionView navigationController:defaultNavigation];
}

-(UIViewController *)presentationForView:(UIViewController *)presentingView style:(UIModalPresentationStyle)style{
    _currentIndex = 0;
    [_navigationController popToViewController:nil animated:NO];
    [_navigationController pushViewController:self.currentView animated:NO];
    _presenter = [[UIPresentationController alloc]initWithPresentedViewController:_navigationController presentingViewController:presentingView];
    _presenter.delegate = self;
    _modalStyle = style;
    return _navigationController;
}

-(ATCOnboardingAuthItem *)authItemAtIndex:(NSUInteger)index{
    return _authTypes[index];
}

-(UIViewController<ATCOnboardingView> *)currentView{
    if(self.currentIndex < _authTypes.count){
        return [self authItemAtIndex:_currentIndex].view;
    }else{
        return _completionView;
    }
}

-(void)nextItemWithAuth{
    if(_currentIndex < _authTypes.count){
        ATCOnboardingAuth type = [self authItemAtIndex:_currentIndex].authType;
        switch (type) {
            case ATCOnboardingAuthCamera:
                [self requestCameraAuth:[self handleRequest]];
                break;
            case ATCOnboardingAuthPhotos:
                [self requestPhotosAuth:[self handlePhotosrequest]];
                break;
            case ATCOnboardingAuthMicrophone:
                [self requestMicrophoneAuth:[self handleRequest]];
                break;
            case ATCOnboardingAuthLocationForeground:
                [self requestForegroundLocationAuth];
                break;
            case ATCOnboardingAuthLocationBackground:
                [self requestBackgroundLocationAuth];
                break;
        }
    }else{
        [self nextItem];
    }
}

-(void)requestForegroundLocationAuth{
    _manager = [[CLLocationManager alloc] init];
    _manager.delegate = self;
    [_manager requestWhenInUseAuthorization];
}

-(void)requestBackgroundLocationAuth{
    _manager = [[CLLocationManager alloc] init];
    _manager.delegate = self;
    [_manager requestAlwaysAuthorization];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status != kCLAuthorizationStatusNotDetermined){
        _manager = nil;
        [self nextItem];
    }
}

-(void)requestCameraAuth:(void (^)(BOOL granted))handler{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:handler];
}

-(void)requestPhotosAuth:(void (^)(PHAuthorizationStatus))handler{
    [PHPhotoLibrary requestAuthorization:handler];
}

-(void)requestMicrophoneAuth:(void (^)(BOOL granted))handler{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:handler];
}

-(void (^)(PHAuthorizationStatus))handlePhotosrequest{
    __weak ATCOnboardingSession *weakSelf = self;
    return ^(PHAuthorizationStatus status){
        ATCOnboardingSession *blockSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(),
                       ^(){
                           [blockSelf nextItem];
                       });
    };
}

-(void (^)(BOOL granted))handleRequest{
    __weak ATCOnboardingSession *weakSelf = self;
    return ^(BOOL granted){
        ATCOnboardingSession *blockSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(),
                       ^(){
                           [blockSelf nextItem];
                       });
    };
}

+(BOOL)needsAuthorization:(ATCOnboardingAuth) authType{
    switch (authType) {
        case ATCOnboardingAuthCamera:
            return [self cameraNeedsAuth];
        case ATCOnboardingAuthLocationBackground:
            return [self locationNeedsAuth];
            break;
        case ATCOnboardingAuthLocationForeground:
            return [self locationNeedsAuth];
            break;
        case ATCOnboardingAuthMicrophone:
            return [self microphoneNeedsAuth];
        case ATCOnboardingAuthPhotos:
            return [self photosNeedsAuth];
    }
    return NO;
}

+(BOOL)cameraNeedsAuth{
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusNotDetermined;
}

+(BOOL)microphoneNeedsAuth{
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio] == AVAuthorizationStatusNotDetermined;
}

+(BOOL)photosNeedsAuth{
    return [PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined;
}

+(BOOL)locationNeedsAuth{
    return [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined;
}

+(BOOL)checkAuthAllowed:(ATCOnboardingAuth) authType{
    return NO;
}



-(void)nextItem{
    _currentIndex ++;
    if(_currentIndex < _authTypes.count + 1){
        UIViewController<ATCOnboardingView> *currentView = self.currentView;
        if(currentView != nil){
            [_navigationController pushViewController:currentView animated:YES];
        }else{
            [_navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }else{
        [_navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
