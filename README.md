Introduction
--------------

OpinionzRate is a class designed to simplify the way you remind your users to review your app on the App Store. It has unique designs for prompting user and we are going to add new design evenatually. Read on below for how to get started.

Supported OS & SDK Versions
-----------------------------

* Supported build target - iOS 7.0 (Xcode 6.2)


ARC Compatibility
------------------

OpinionzRate requires ARC. 

Сocoapods version
------------------

```ruby
pod 'OpinionzRate', '~> 1.0'
```

Installation
--------------
###Cocoapods
To install via CocoaPods add this line to your Podfile
```ruby
use_frameworks!
pod "OpinionzRate"
```

###Manual
To install manually the OpinionzRate class in an app, just drag the OpinionzRate, OpinionzRateView class files (demo files and assets are not needed) into your project. You need to add StoreKit framework to your app.


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
Message of the rate popup (default is "__Would you mind taking a moment to rate it? It won’t take more than a minute. Thanks for your support!_"


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


Protocols
---------------

Thread Safety
--------------

Release Notes
----------------

Version 1.0

- Release version.

