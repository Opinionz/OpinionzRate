//
//  OpinionzCustomRateView.h
//  OpinionzRate
//
//  Created by Armen Mkrtchian on 26/09/15.
//  Copyright (c) 2015 Armen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OpinionzRate.h"

@interface OpinionzCustomRateView : UIView

/*!
 * @property
 * @discussion OpinionzRateDelegate.
 * @since 1.0+
 */
@property (nonatomic, weak) id <OpinionzRateDelegate>delegate;

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
 * @discussion Cancel button title.
 * @since 1.0+
 */
@property (nonatomic, strong) NSString *cancelTitle;

/*!
 * @property
 * @discussion Rate button title.
 * @since 1.0+
 */
@property (nonatomic, strong) NSString *rateTitle;

/*!
 * @property
 * @discussion Rate Later button title.
 * @since 1.0+
 */
@property (nonatomic, strong) NSString *rateLaterTitle;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil;

@end
