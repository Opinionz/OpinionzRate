//
//  OpinionzRate.m
//  RatePopup
//
//  Created by Anatoli Petrosyants on 8/21/15.
//  Copyright (c) 2015 Anatoli Petrosyants. All rights reserved.
//

#import <StoreKit/StoreKit.h>
#import "OpinionzRate.h"
#import "OpinionzAlertView.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@interface OpinionzRate () <SKStoreProductViewControllerDelegate, OpinionzAlertViewDelegate>

@property (nonatomic, assign) NSUInteger appStoreID;
@property (nonatomic, strong) NSString *applicationName;
@property (nonatomic, strong) OpinionzAlertView *alertView;

@end

@implementation OpinionzRate

// MARK: Public methods

// Get the shared instance and create it using GCD.
+ (OpinionzRate *)sharedInstance {
    
    static OpinionzRate *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

// Register App store id and start checking reachability.
- (void)setupWithAppStoreId:(NSUInteger)appStoreID {
    
    if (appStoreID <= 0) {
        
        [NSException raise:@"Invalid app store id" format:@"API key of %lu is invalid", (unsigned long)appStoreID];
    }
    else {
        
        self.appStoreID = appStoreID;
    }
}

// Regular init method, that will get called the first.
- (instancetype)init {
    
    self = [super init];
    if (self != nil) {
        
        [self privatePropertiesInitialization];
    }
    return  self;
}

// Private properties initialization for calling in Init.
- (void)privatePropertiesInitialization {
    
    // TODO: Make localized string. A.P.
    self.applicationName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    if ([self.applicationName length] == 0) {
        
        self.applicationName = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey];
    }
}

// Check prompt for rating conditions.
- (void)promptForRating {
    
    NSString *kRatedCurrentVersionString = [self ratedCurrentVersionString];
    BOOL kRatedCurrentVersion = [[NSUserDefaults standardUserDefaults] boolForKey:kRatedCurrentVersionString];
    
    if (!kRatedCurrentVersion) {
        
        [self.alertView show];
    }
    else {
        
        NSLog(@"OPININONZ NOTE: Already rated this version or declined to rate");
    }

}

// MARK: OpinionzPopupViewDelegate

- (void)alertView:(OpinionzAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //TODO: change button indexes or add enum A.M.
    switch (buttonIndex) {
        case 0:
            [self rejectRate];
            break;
        case 1:
            [self rateApp];
            break;
        case 2:
            // TODO: discuss "remind me later" solution. A.P.
            // Track the event
            break;
        default:
            break;
    }
}

// MARK: Setters/Getters
- (NSString *)title {
    
    return _title ? _title : [NSString stringWithFormat:@"Enjoying %@?", self.applicationName];
}

- (NSString *)message {
    
    return _message ? _message : [NSString stringWithFormat:@"Would you mind taking a moment to rate it? It won’t take more than a minute.\nThanks for your support!"];
}

- (NSString *)cancelTitle {
    
    return _cancelTitle ? _cancelTitle : @"No, Thanks";
}

- (NSString *)rateTitle {
    
    return _rateTitle ? _rateTitle : @"Rate me";
}

- (NSString *)rateLaterTitle {
    
    return _rateLaterTitle ? _rateLaterTitle :  @"Remind me later";
}

- (NSString *)ratedCurrentVersionString {
    
    return [NSString stringWithFormat:@"%@-%@", @"Opinionz", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
}

- (OpinionzAlertView *)alertView {
    
    _alertView = [[OpinionzAlertView alloc] initWithTitle:self.title
                                                  message:self.message
                                                 delegate:self
                                        cancelButtonTitle:self.cancelTitle
                                        otherButtonTitles:@[self.rateTitle, self.rateLaterTitle]];
    
    return _alertView;
}

// MARK: Private methods
- (void)rateApp {
    
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"OPININONZ NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
#else
    
    // TODO: Track event with module
    NSString *kRatedCurrentVersionString = [self ratedCurrentVersionString];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kRatedCurrentVersionString];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSNumber *appId = [NSNumber numberWithInteger:self.appStoreID];
    if (NSStringFromClass([SKStoreProductViewController class]) != nil) {
        
        SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
        [storeViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:appId} completionBlock:nil];
        storeViewController.delegate = self;
        
        //TODO: Notify delegate about presenting SKStoreProductViewController
        UIViewController *rootViewController = [self getRootViewController];
        [rootViewController presentViewController:storeViewController animated:YES completion:^{
            
            // TODO: Temporarily use a black status bar to match the StoreKit view.
            // Remember last status bar style for restore
            [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        }];
    }
#endif
}

- (void)rejectRate {
    
    // TODO: Track event with module
    NSString *kRatedCurrentVersionString = [self ratedCurrentVersionString];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kRatedCurrentVersionString];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// TODO: remove after we have all set
- (UIViewController *)getRootViewController {
    
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows){
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            return window.rootViewController;
        }
    }
    return nil;
}

// MARK: SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
