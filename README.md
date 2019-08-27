# Goal

OpinionzRate simplifies the way you remind the users to review your app on the App Store. It has unique designs for prompting user and we are going to add new design eventually.


# Screenshots
| ![Fullscreen](https://i.imgur.com/CVRDYeh.png) | ![Popup](https://i.imgur.com/fLglmKi.png) | ![Default](https://i.imgur.com/whGUH7B.png) |
|--|--|--|
| Fullscreen | Popup  | Default |


# Roadmap

 - New designs
 - Customizable color schemes
 - Feedback mechanism
 - API support for sending analytics events



# Installation
### Cocoapods

OpinionzRate is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'OpinionzRate', '~> 0.3.0'
```

### Manual
1. Add the OpinionzRate code into your project.
2. Add the `StoreKit` frameworks to your project.

### Setup
1. Add  `@import OpinionzRate`  in your AppDelegate.m
2.  Call  `OpinionzRate.shared.setupWithAppStoreId(YOUR_APP_ID)`  with the app id provided by Apple. A good place to do this is at the beginning of your app delegate's  `application:didFinishLaunchingWithOptions:`  method.
3.  Add  `@import OpinionzRate`  in your class where you want to ask user for review.
4.  Call  `OpinionzRate.sharedInstance.promptForRating()`  at your desired action



# Usage

<table>
 <thead>
<tr>
<th>Example code</th>
<th>Screenshot</th>
</tr>
</thead>
<tr>
<td>
 Default
  <pre lang="swift">
  OpinionzRate.shared.headerImage = UIImage(named: "dinner-table")
  OpinionzRate.shared.title = "My Great App" </br> 
  OpinionzRate.shared.type = .default </br> 
  OpinionzRate.shared.promptForRating()
  </pre>
</td>
<td>
 <img src="https://i.imgur.com/whGUH7B.png" alt="Default" width="250">
</td>
</tr>
<tr>
<td>
 Popup
  <pre lang="swift">
  OpinionzRate.shared.headerImage = UIImage(named: "dinner-table")
  OpinionzRate.shared.title = "Popup" </br> 
  OpinionzRate.shared.type = .popup </br> 
  OpinionzRate.shared.promptForRating()
  </pre>
</td>
<td>
 <img src="https://i.imgur.com/whGUH7B.png" alt="Popup" width="250">
</td>
</tr>
<tr>
<td>
 Fullscreen
  <pre lang="swift">
  OpinionzRate.shared.headerImage = UIImage(named: "dinner-table")
  OpinionzRate.shared.title = "Fullscreen" </br> 
  OpinionzRate.shared.type = .fullscreen </br> 
  OpinionzRate.shared.promptForRating()
  </pre>
</td>
<td>
 <img src="https://i.imgur.com/CVRDYeh.png" alt="Fullscreen" width="250">
</td>
</tr>
</table>

# Contacts

Opinionz.io, [support@opinionz.io](mailto:support@opinionz.io)
