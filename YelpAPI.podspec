#
# Be sure to run `pod lib lint YelpAPI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YelpAPI"
  s.version          = "1.0.0"
  s.summary          = "Objective-C client library for accessing the Yelp Public API."

  s.description      = <<-DESC
			This pod is designed to help developers using both Objective-C 
			and Swift in accessing the Yelp Public API. A thorough
			readme with usage examples can be found at https://github.com/Yelp/yelp-ios.
                       DESC

  s.homepage         = "https://github.com/Yelp/yelp-ios"
  s.license          = 'MIT'
  s.author           = { "David Chen" => "ywchen@yelp.com" }
  s.source           = { :git => "https://github.com/Yelp/yelp-ios.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'TDOAuth', '~> 1.1'
end
