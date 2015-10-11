//
//  OPZViewController.m
//  OpinionzRate
//
//  Created by Armen on 09/06/2015.
//  Copyright (c) 2015 Armen. All rights reserved.
//

#import "OPZViewController.h"

#import <OpinionzRate/OpinionzRate.h>
#import <OpinionzRate/OpinionzCustomRateView.h>

@interface OPZViewController ()

@end

@implementation OPZViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonHandlerRate1 {
    
    //Optional customization
//    [OpinionzRate sharedInstance].title = @"Do you love our app?";
//    [OpinionzRate sharedInstance].message = @"Would you mind taking a moment to rate it? It won’t take more than a minute. Thanks for your support!";
//    [OpinionzRate sharedInstance].cancelTitle = @"No, thanks";
//    [OpinionzRate sharedInstance].rateTitle = @"Rate now";
//    [OpinionzRate sharedInstance].rateLaterTitle = @"Remind me later";

    [OpinionzRate sharedInstance].headerImage = [UIImage imageNamed:@"dinner-table"];
    [OpinionzRate sharedInstance].title = @"My Great App";
    [OpinionzRate sharedInstance].type = RateViewTypeDefault;
    [[OpinionzRate sharedInstance] promptForRating];
}

- (IBAction)buttonHandlerRate2 {
    
//    OpinionzCustomRateView *myViewObject = [[OpinionzCustomRateView alloc] initWithNibName:@"OPZCustomRateView2"];
//    [OpinionzRate sharedInstance].rateView = myViewObject;
    
    [OpinionzRate sharedInstance].headerImage = [UIImage imageNamed:@"dinner-table"];
    [OpinionzRate sharedInstance].title = @"Popup";
    [OpinionzRate sharedInstance].type = RateViewTypePopup;
    [[OpinionzRate sharedInstance] promptForRating];
}

- (IBAction)buttonHandlerRate3 {
    
//    OpinionzCustomRateView *myViewObject = [[OpinionzCustomRateView alloc] initWithNibName:@"OPZCustomRateView3"];
//    [OpinionzRate sharedInstance].rateView = myViewObject;
    
    [OpinionzRate sharedInstance].headerImage = nil;
    [OpinionzRate sharedInstance].title = @"Fullscreen";
    [OpinionzRate sharedInstance].type = RateViewTypeFullscreen;
    [[OpinionzRate sharedInstance] promptForRating];
}
@end
