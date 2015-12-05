#
# Be sure to run `pod lib lint SUImageComparisonView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SUImageComparisonView"
  s.version          = "0.1.0"
  s.summary          = "An iOS View that let you swipe to reveal portions of two images like http://imgur.com/eyxNQM9"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = "An iOS View that let you swipe to reveal portions of two images like http://imgur.com/eyxNQM9 
  Features
    Support 2 UIImages
    The view contentMode property will be applied to the internal UIImageViews.
    Configurable initial slider position. Snappable left and right slider position (In case you want to slightly reveal the other image). 
    Configurable left and right image tint."

  s.homepage         = "https://github.com/5un/SUImageComparisonView"
  # s.screenshots     = "http://imgur.com/eyxNQM9"
  s.license          = 'MIT'
  s.author           = { "Soravis Prakkamakul" => "asunnotthesun@gmail.com" }
  s.source           = { :git => "https://github.com/5un/SUImageComparisonView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SUImageComparisonView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
