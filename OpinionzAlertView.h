//
//  OpinionzRate.h
//  OpinionzRate
//
//  Created by Opinionz.io on 8/16/15.
//  Copyright (c) 2015 Opinionz.io. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OpinionzAlertView;
@protocol OpinionzAlertViewDelegate;

typedef void (^OpinionzPopupViewTapButtonBlock)(OpinionzAlertView *alertView, NSInteger buttonIndex);

@interface OpinionzAlertView : UIView

@property (nonatomic, assign) id<OpinionzAlertViewDelegate> delegate;
@property (nonatomic, copy) OpinionzPopupViewTapButtonBlock buttonDidTappedBlock;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                     delegate:(id /*<UIAlertViewDelegate>*/)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
      usingBlockWhenTapButton:(OpinionzPopupViewTapButtonBlock)tapButtonBlock;

- (void)show;

- (void)dismiss;

@end

@protocol OpinionzAlertViewDelegate <NSObject>
- (void)alertView:(OpinionzAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
