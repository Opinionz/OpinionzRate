//
//  OpinionzCustomRateView.m
//  OpinionzRate
//
//  Created by Armen Mkrtchian on 26/09/15.
//  Copyright (c) 2015 Armen. All rights reserved.
//

#import "OpinionzCustomRateView.h"

@interface OpinionzCustomRateView () <OpinionzRateDelegate>
@property UIView *view;

/*!
 * @property
 * @discussion Header imageView.
 * @since 1.0+
 */
@property (nonatomic, strong) IBOutlet UIImageView *imageViewHeader;

/*!
 * @property
 * @discussion Title of Rate.
 * @since 1.0+
 */
@property (nonatomic, strong) IBOutlet UILabel *labelTitle;

/*!
 * @property
 * @discussion Short description of Rate.
 * @since 1.0+
 */
@property (nonatomic, strong) IBOutlet UILabel *labelShortDescription;

/*!
 * @property
 * @discussion Rate label.
 * @since 1.0+
 */
@property (nonatomic, strong) IBOutlet UILabel *labelRate;

/*!
 * @property
 * @discussion Message of Rate.
 * @since 1.0+
 */
@property (nonatomic, strong) IBOutlet UILabel *labelMessage;

/*!
 * @property
 * @discussion Cancel button.
 * @since 1.0+
 */
//@property (nonatomic, strong) IBOutlet UIButton *labelCancelTitle;

/*!
 * @property
 * @discussion Rate Later button.
 * @since 1.0+
 */
@property (nonatomic, strong) IBOutlet UIButton *buttonRateLater;

/*!
 * @property
 * @discussion Rate button.
 * @since 1.0+
 */
@property (nonatomic, strong) IBOutlet UIButton *buttonRate;

/*!
 * @property
 * @discussion Rate button.
 * @since 1.0+
 */
@property (nonatomic, strong) NSNumber *selectedStars;


@property (nonatomic, strong) IBOutlet UIButton *star1;
@property (nonatomic, strong) IBOutlet UIButton *star2;
@property (nonatomic, strong) IBOutlet UIButton *star3;
@property (nonatomic, strong) IBOutlet UIButton *star4;
@property (nonatomic, strong) IBOutlet UIButton *star5;

@end

@implementation OpinionzCustomRateView

- (instancetype)initWithNibName:(NSString *)nibNameOrNil {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        
        self.view = [self loadViewFromNib:nibNameOrNil];
        [self xibSetup];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    self = [super initWithFrame:frame];
//    
//    if (self) {
//        
//        [self xibSetup];
//    }
//    
//    return self;
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    
//    self = [super initWithCoder:aDecoder];
//    
//    if (self) {
//        
//        [self xibSetup];
//    }
//    
//    return self;
//}
//
- (void)xibSetup {
    
    // use bounds not frame or it'll be offset
    self.view.frame = self.bounds;
    
    // Adding custom subview on top of our view (over any custom drawing > see note below)
    [self addSubview:self.view];
}

- (UIView *)loadViewFromNib:(NSString *)nibNameOrNil {
    
    UINib *nib = [UINib nibWithNibName:nibNameOrNil ? nibNameOrNil : @"OpinionzCustomRateView" bundle:[self bundle]];
    
    // Assumes UIView is top level and only object in CustomView.xib file
    UIView *view = [nib instantiateWithOwner:self options:nil][0];
    return view;
}

- (NSBundle *)bundle {
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"OpinionzRate" ofType:@"bundle"];
    if (!bundlePath) {
        
        bundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"OpinionzRate" ofType:@"bundle"];
    }
    
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    if (!bundle) {
        
        bundle = [NSBundle mainBundle];
    }
    
//    NSBundle *bundle = [NSBundle mainBundle];
    
    return bundle;
}
//- (void)setupViewData {
//    
//    self.labelTitle.text = self.title;
//    self.labelShortDescription.text = self.shortDescription;
//    self.labelRateTitle.text = self.rateTitle;
//    self.labelMessage.text = self.message;
//    [self.labelCancelTitle setTitle:self.cancelTitle forState:UIControlStateNormal];
//    [self.labelRateLaterTitle setTitle:self.rateLaterTitle forState:UIControlStateNormal];
//}

- (void)setHeaderImage:(UIImage *)headerImage {
    
    _headerImage = headerImage;
    self.imageViewHeader.image = self.headerImage;
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    self.labelTitle.text = self.title;
}

- (void)setShortDescription:(NSString *)shortDescription {
    
    _shortDescription = shortDescription;
    self.labelShortDescription.text = self.shortDescription;
}

- (void)setRateTitle:(NSString *)rateTitle {
    
    _rateTitle = rateTitle;
    [self.buttonRate setTitle:self.rateTitle forState:UIControlStateNormal];
}

- (void)setMessage:(NSString *)message {
    
    _message = message;
    self.labelMessage.text = self.message;
}

//- (void)setCancelTitle:(NSString *)cancelTitle {
//
//    _cancelTitle = cancelTitle;
//    [self.labelCancelTitle setTitle:self.cancelTitle forState:UIControlStateNormal];
//}

- (void)setRateLaterTitle:(NSString *)rateLaterTitle {
    
    _rateLaterTitle = rateLaterTitle;
    [self.buttonRateLater setTitle:self.rateLaterTitle forState:UIControlStateNormal];
}

- (IBAction)rateStar:(UIButton *)sender {
    
    self.selectedStars = @(sender.tag);
    
    NSBundle *bundle = [self bundle];
    // clear stars
    UIImage *starGray = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"star_gray@2x" ofType:@"png"]];
    
    [self.star1 setImage:starGray forState:UIControlStateNormal];
    [self.star2 setImage:starGray forState:UIControlStateNormal];
    [self.star3 setImage:starGray forState:UIControlStateNormal];
    [self.star4 setImage:starGray forState:UIControlStateNormal];
    [self.star5 setImage:starGray forState:UIControlStateNormal];

    UIImage *starBlue = [[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"star_blue@2x" ofType:@"png"]];
    switch (sender.tag) {
        case 5:
            [self.star5 setImage:starBlue forState:UIControlStateNormal];
        case 4:
            [self.star4 setImage:starBlue forState:UIControlStateNormal];
        case 3:
            [self.star3 setImage:starBlue forState:UIControlStateNormal];
        case 2:
            [self.star2 setImage:starBlue forState:UIControlStateNormal];
        case 1:
            [self.star1 setImage:starBlue forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

- (IBAction)rateAppWithStars {
    
    if (self.selectedStars) {
        
        if ([self.delegate respondsToSelector:@selector(rateStar:)]) {
            
            [self.delegate rateStar:self.selectedStars];
        }
    }
}

- (IBAction)rateApp {
    
    if ([self.delegate respondsToSelector:@selector(rateApp)]) {
        
        [self.delegate rateApp];
    }
}

- (IBAction)rejectToRate {
    
    if ([self.delegate respondsToSelector:@selector(rejectToRate)]) {
        
        [self.delegate rejectToRate];
    }
}

- (IBAction)close {
    
    if ([self.delegate respondsToSelector:@selector(rejectToRate)]) {
        
        [self.delegate rejectToRate];
    }
}

@end
