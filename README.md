Introduction
--------------

OpinionzRate is a class designed to simplify the way you remind your users to review your app on the App Store. It has unique designs for prompting user and we are going to add new design eventually. Read on below for how to get started.

Installation
--------------
###Cocoapods
To install via CocoaPods add this line to your Podfile
```ruby
pod 'OpinionzRate', '~> 1.0'
```

###Manual
1. Add the OpinionzRate code into your project.
2. Add the `StoreKit` frameworks to your project.

Usage
--------------
1. Add `#import <OpinionzRate.h>` in your AppDelegate.m
2. Call `[[OpinionzRate sharedInstance] setupWithAppStoreId:YOUR_APP_ID]` with the app id provided by Apple. A good place to do this is at the beginning of your app delegate's `application:didFinishLaunchingWithOptions:` method.
3. Add `#import <OpinionzRate.h>` in your class where you want to ask user for review and call `[[OpinionzRate sharedInstance] promptForRating]` at your desired action (NOTE: call it after your view did appeared)

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

Protocols
---------------

Thread Safety
--------------

Release Notes
----------------

Version 1.0

- Release version.

