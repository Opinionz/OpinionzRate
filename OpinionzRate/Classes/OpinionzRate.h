//
//  OpinionzRate.h
//  OpinionzRate
//
//  Created by Opinionz.io on 8/16/15.
//  Copyright (c) 2015 Opinionz.io. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RateViewType) {
    RateViewTypeDefault,
    RateViewTypePopup,
    RateViewTypeFullscreen
};

@class OpinionzCustomRateView;

@protocol OpinionzRateDelegate <NSObject>
@required
- (void)rateStar:(NSNumber *)star;
- (void)rateApp;
- (void)rejectToRate;

@end

/*!
 * @brief OpinionzRate: single manager
 *
 */
@interface OpinionzRate : NSObject

@property (nonatomic) RateViewType type;
@property (nonatomic) BOOL debugMode;

/*!
 * @property
 * @discussion Header image.
 * @since 1.0+
 */
@property (nonatomic, strong) UIImage *headerImage;

/*!
 * @property
 * @discussion Title of Rate.
 * @since 1.0+
 */
@property (nonatomic, strong) NSString *title;

/*!
 * @property
 * @discussion Short description of Rate.
 * @since 1.0+
 */
@property (nonatomic, strong) NSString *shortDescription;

/*!
 * @property
 * @discussion Message of Rate.
 * @since 1.0+
 */
@property (nonatomic, strong) NSString *message;

/*!
 * @property
 * @discussion Cancel button title of Rate.
 * @since 1.0+
 */
@property (nonatomic, strong) NSString *cancelTitle;

/*!
 * @property
 * @discussion Rate button title of Rate.
 * @since 1.0+
 */
@property (nonatomic, strong) NSString *rateTitle;

/*!
 * @property
 * @discussion Rate Later button title of Rate.
 * @since 1.0+
 */
@property (nonatomic, strong) NSString *rateLaterTitle;

/*!
 * @property
 * @discussion Feedback email.
 * @since 1.0+
 */
@property (nonatomic, strong) NSString *feedbackEmail;

/*!
 * @discussion sharedInstance Required method for getting single manager. The recommended way to set library into your application is to place a call
 * to sharedInstance in your -application:didFinishLaunchingWithOptions: method.
 * @exception NSException Thrown when the instance is 'nil'.
 * @return Return OpinionzRate single object.
 * @since 1.0+
 */
+ (OpinionzRate *)sharedInstance;

/*!
 * @param appStoreID app store identifier provided by user
 * @discussion setupWithAppStoreId: register app store id and start using Opinionz SDK.
 * @exception NSException Thrown when app store id is 'nil' or empty.
 * @since 1.0+
 */
- (void)setupWithAppStoreId:(NSUInteger)appStoreID;

/*!
 * @discussion promptForRating show rate popup.
 * @exception NSException Thrown when app store id is 'nil' or empty.
 * @since 1.0+
 */
- (void)promptForRating;

@end
