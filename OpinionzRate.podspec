Pod::Spec.new do |s|
    s.name             = "OpinionzRate"
    s.version          = "0.1.0"
    s.summary          = "OpinionzRate: Remind your users to review"
    s.description      = <<-DESC
    OpinionzRate is a class designed to simplify the way you remind your users to review your app on the App Store. It has unique designs for prompting user and we are going to add new design eventually.
    DESC

    s.homepage         = "https://opinionz.github.io/OpinionzRate"
    # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
    s.license          = 'MIT'
    s.author           = { "Armen" => "armen.mkrtchian@gmail.com", "Tolik" => "tolik.petrosyants@gmail.com" }
    s.source           = { :git => "https://github.com/Opinionz/OpinionzRate.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'OpinionzRate/Classes/*'
#  s.resource_bundles = {
#    'OpinionzRate' => ['OpinionzRate/Assets/Images/*.png']
#  }
  s.resource_bundle = { 'OpinionzRate' => 'OpinionzRate/Assets/Images/*.png' }

  # s.public_header_files = 'OpinionzRate/Classes/**/*.h'
  s.frameworks = 'StoreKit'
  s.dependency 'OpinionzAlertView', '~> 0.1.0'
end
