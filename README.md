# OpinionzRate

[![CI Status](http://img.shields.io/travis/Opinionz/OpinionzRate.svg?style=flat)](https://travis-ci.org/Opinionz/OpinionzRate)
[![Version](https://img.shields.io/cocoapods/v/OpinionzRate.svg?style=flat)](http://cocoapods.org/pods/OpinionzRate)
[![License](https://img.shields.io/cocoapods/l/OpinionzRate.svg?style=flat)](http://cocoapods.org/pods/OpinionzRate)
[![Platform](https://img.shields.io/cocoapods/p/OpinionzRate.svg?style=flat)](http://cocoapods.org/pods/OpinionzRate)

Introduction
--------------

OpinionzRate is a class designed to simplify the way you remind your users to review your app on the App Store. It has unique designs for prompting user and we are going to add new design eventually. Read on below for how to get started.

Installation
--------------
###Cocoapods

OpinionzRate is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OpinionzRate', '~> 0.3.0'
```

###Manual
1. Add the OpinionzRate code into your project.
2. Add the `StoreKit` frameworks to your project.


## Communication

- If you **found a bug**, _and can provide steps to reliably reproduce it_, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

Usage
--------------
1. Add `#import <OpinionzRate.h>` in your AppDelegate.m
2. Call `[[OpinionzRate sharedInstance] setupWithAppStoreId:YOUR_APP_ID]` with the app id provided by Apple. A good place to do this is at the beginning of your app delegate's `application:didFinishLaunchingWithOptions:` method.
3. Add `#import <OpinionzRate.h>` in your class where you want to ask user for review. 
4. Call `[[OpinionzRate sharedInstance] promptForRating]` at your desired action

NOTE: prompt it after your view did appeared

###Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```objective-c
//
//  AppDelegate.m
//  Demo
//
//  Created by Opinionz.io on 18/08/15.
//  Copyright (c) 2015 Opinionz.io. All rights reserved.
//

#import <OpinionzRate.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [[OpinionzRate sharedInstance] setupWithAppStoreId:995007460];

    return YES;
}
```

```objective-c
//
//  ViewController.m
//  Demo
//
//  Created by Opinionz.io on 18/08/15.
//  Copyright (c) 2015 Opinionz.io. All rights reserved.
//

#import "ViewController.h"

#import <OpinionzRate.h>

- (IBAction)buttonHandlerRate:(id)sender {
    //Optional customization
//    [OpinionzRate sharedInstance].title = @"Do you love our app?";
//    [OpinionzRate sharedInstance].message = @"Would you mind taking a moment to rate it? It won’t take more than a minute. Thanks for your support!";
//    [OpinionzRate sharedInstance].cancelTitle = @"No, thanks";
//    [OpinionzRate sharedInstance].rateTitle = @"Rate now";
//    [OpinionzRate sharedInstance].rateLaterTitle = @"Remind me later";

    [[OpinionzRate sharedInstance] promptForRating];
}
```

Configuration
-------------
You can set `title`, `message`, `cancelTitle`, `rateTitle` and `rateLaterTitle` messages. If some of them are not set, default values will be used.

Properties
--------------

The OpinionzRate has the following properties:
```objective-c
@property (nonatomic, strong) NSString *title;
```
Title of the rate popup (default is __"Enjoying _Application name_?"__

```objective-c
@property (nonatomic, strong) NSString *message;
```
Message of the rate popup (default is "__Would you mind taking a moment to rate it? It won’t take more than a minute. Thanks for your support!__"


```objective-c
@property (nonatomic, strong) NSString *cancelTitle;
```
Cancel button title (default is __"No, Thanks"__


```objective-c
@property (nonatomic, strong) NSString *rateTitle;
```
Rate button title (default is __"Rate me"__

```objective-c
@property (nonatomic, strong) NSString *rateLaterTitle;
```
Rate later button title (default is __"Remind me later"__


Methods
--------------

The OpinionzRate class has the following methods:
```objective-c
+ (OpinionzRate *)sharedInstance;
```
Required method for getting single manager. The recommended way to set library into your application is to place a call to sharedInstance in your -application:didFinishLaunchingWithOptions: method.


```objective-c
- (void)setupWithAppStoreId:(NSUInteger)appStoreID;
```
Register app with store id and start using Opinionz SDK.


```objective-c
- (void)promptForRating;
```
Show rate popup at your desired time

Supported OS & SDK Versions
-----------------------------

* Supported build target - iOS 7.0 (Xcode 6.2)


ARC Compatibility
------------------

OpinionzRate requires ARC. 

Release Notes
----------------

Version 0.3.0

- New designs.

Version 0.2.0

- Initial version.

## Author

Opinionz.io, support@opinionz.io

## License

OpinionzRate is available under the MIT license. See the LICENSE file for more info.

