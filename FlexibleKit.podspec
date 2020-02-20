#
# Be sure to run `pod lib lint FlexibleKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FlexibleKit'
  s.version          = '0.1.13'
  s.summary          = 'FlexibleKit is a library for flexible page implementation in Filmgrail(c) apps.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
FlexibleKit is a library for flexible page implementation in Filmgrail(c) kino apps. Supported both iOS 13 and earlear versions.
In iOS 13 uses system methods and classes like compositional layout and diffable data source. For iOS 12 and below uses custom implementation.
                       DESC

  s.homepage         = 'https://github.com/BozhkoAlexander/FlexibleKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BozhkoAlexander' => 'alexander.bozhko@filmgrail.com' }
  s.source           = { :git => 'https://github.com/BozhkoAlexander/FlexibleKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'

  s.source_files = 'FlexibleKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FlexibleKit' => ['FlexibleKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
