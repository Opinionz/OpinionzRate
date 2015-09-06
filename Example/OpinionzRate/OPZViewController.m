//
//  OPZViewController.m
//  OpinionzRate
//
//  Created by Armen on 09/06/2015.
//  Copyright (c) 2015 Armen. All rights reserved.
//

#import "OPZViewController.h"

#import <OpinionzRate/OpinionzRate.h>

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

- (IBAction)buttonHandlerRate:(id)sender {
    
    //Optional customization
    [OpinionzRate sharedInstance].title = @"Do you love our app?";
    [OpinionzRate sharedInstance].message = @"Would you mind taking a moment to rate it? It won’t take more than a minute. Thanks for your support!";
//    [OpinionzRate sharedInstance].cancelTitle = @"No, thanks";
//    [OpinionzRate sharedInstance].rateTitle = @"Rate now";
//    [OpinionzRate sharedInstance].rateLaterTitle = @"Remind me later";
    
     [[OpinionzRate sharedInstance] promptForRating];
}

@end
