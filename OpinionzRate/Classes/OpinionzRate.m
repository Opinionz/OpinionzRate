//
//  OpinionzRate.m
//  RatePopup
//
//  Created by Anatoli Petrosyants on 8/21/15.
//  Copyright (c) 2015 Anatoli Petrosyants. All rights reserved.
//

#import <StoreKit/StoreKit.h>
#import <MessageUI/MessageUI.h>
#import "OpinionzRate.h"
#import "OpinionzCustomRateView.h"

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

@interface OpinionzRate () <SKStoreProductViewControllerDelegate, MFMailComposeViewControllerDelegate, OpinionzRateDelegate>

@property (nonatomic, assign) NSUInteger appStoreID;
@property (nonatomic, strong) NSString *applicationName;
@property (nonatomic, strong) OpinionzCustomRateView *rateView;
@end

@implementation OpinionzRate

@synthesize rateView = _rateView;

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
    
    self.debugMode = NO;
}

// Check prompt for rating conditions.
- (void)promptForRating {
    
    NSString *kRatedCurrentVersionString = [self ratedCurrentVersionString];
    BOOL kRatedCurrentVersion = [[NSUserDefaults standardUserDefaults] boolForKey:kRatedCurrentVersionString];
    
    if (!kRatedCurrentVersion || self.debugMode) {
        
        [self show];
    }
    else {
        
        NSLog(@"OPININONZ NOTE: Already rated this version or declined to rate");
    }

}

// MARK: Setters/Getters
- (void)setRateView:(OpinionzCustomRateView *)rateView {
    
//    if ([rateView isKindOfClass:[OpinionzCustomRateView class]]) {
    
        rateView.delegate = self;
        _rateView = rateView;
//    }
}

- (OpinionzCustomRateView *)rateView {
    
    if (!_rateView) {
        
        NSString *nibName;
        switch (self.type) {
            case RateViewTypeDefault:
                nibName = @"OPZCustomRateViewDefault";
                break;
            case RateViewTypePopup:
                nibName = @"OPZCustomRateViewPopup";
                break;
            case RateViewTypeFullscreen:
                nibName = @"OPZCustomRateViewFullscreen";
                break;
                
            default:
                nibName = @"OPZCustomRateViewDefault";
                break;
        }
        _rateView = [[OpinionzCustomRateView alloc] initWithNibName:nibName];
        _rateView.delegate = self;
        
        _rateView.headerImage = self.headerImage;
        _rateView.title = self.title;
        _rateView.shortDescription = self.shortDescription;
        _rateView.rateTitle = self.rateTitle;
        _rateView.message = self.message;
        _rateView.cancelTitle = self.cancelTitle;
        _rateView.rateLaterTitle = self.rateLaterTitle;
    }
    return _rateView;
}

- (NSString *)title {
    
    return _title ? _title : [NSString stringWithFormat:@"Enjoying %@?", self.applicationName];
}

- (NSString *)shortDescription {
    
    return _shortDescription ? _shortDescription : [NSString stringWithFormat:@""];
}

- (NSString *)message {
    
    return _message ? _message : [NSString stringWithFormat:@"Thanks for using our app"];
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

- (NSString *)feedbackEmail {
    
    return _feedbackEmail ? _feedbackEmail :  @"support@example.com";
}

- (NSString *)ratedCurrentVersionString {
    
    return [NSString stringWithFormat:@"%@-%@", @"Opinionz", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
}

// MARK: Private methods
- (void)rateStar:(NSNumber *)star {
    
    switch ([star integerValue]) {
        case 1:
        case 2:
        case 3:
            [self sendFeedback];
            break;
        case 4:
        case 5:
            [self rateApp];
            break;
            
        default:
            break;
    }
}

- (void)rateApp {
    
    [self dismiss];
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
//            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        }];
    }
#endif
}

- (void)rejectToRate {
    
    // TODO: Track event with module
    NSString *kRatedCurrentVersionString = [self ratedCurrentVersionString];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kRatedCurrentVersionString];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismiss];
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

// MARK: Rate View show/dismiss methods
- (void)show {
    
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            
            [window addSubview:self.rateView];
            break;
        }
    }
    
    self.rateView.layer.opacity = 0.0f;
//    self.rateView.layer.transform = CATransform3DMakeScale(0.0f, 0.0f, 1.0);
    
    [UIView animateWithDuration:0.15f
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{

                         self.rateView.layer.opacity = 1.0f;
//                         self.rateView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:NULL];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.15f
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
//                         self.rateView.transform = CGAffineTransformScale(self.rateView.transform, 0.8f, 0.8f);
                         self.rateView.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         
                         [self.rateView removeFromSuperview];
                         self.rateView = nil;
                     }];
}


- (void)sendFeedback {
    
    [self dismiss];
    
    NSLog(@"send feedback");
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        
        NSString *deviceInfo = [NSString stringWithFormat:@"%@, (%@)", [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion]];
        NSString *infoString = [NSString stringWithFormat:@"\n\n\n##################\nApplication: %@\nDevice: %@\n##################", self.applicationName, deviceInfo];
        
        [mailComposeViewController setMailComposeDelegate:self];
        [mailComposeViewController setToRecipients:@[self.feedbackEmail]];
        [mailComposeViewController setSubject:@"Let us know"];
        [mailComposeViewController setMessageBody:infoString isHTML:NO];
        
        UIViewController *rootViewController = [self getRootViewController];
        [rootViewController presentViewController:mailComposeViewController animated:YES completion:nil];
    }
}

#pragma mark -- MFMailComposeViewControllerDelegate --
-(void)mailComposeController:(MFMailComposeViewController*)controller
         didFinishWithResult: (MFMailComposeResult)result
                       error:(NSError*)error
{
    UIViewController *rootViewController = [self getRootViewController];
    [rootViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
