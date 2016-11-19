#
# Be sure to run `pod lib lint YelpAPI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YelpAPI"
  s.version          = "1.1.0"
  s.summary          = "Objective-C client library for accessing the Yelp Public API."

  s.description      = <<-DESC
			This pod is designed to help developers using both Objective-C 
			and Swift in accessing the Yelp Public API. A thorough
			readme with usage examples can be found at https://github.com/Yelp/yelp-ios.
                       DESC

  s.homepage         = "https://github.com/Yelp/yelp-ios"
  s.license          = 'MIT'
  s.author           = 'Yelp'
  s.source           = { :git => "https://github.com/Yelp/yelp-ios.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.requires_arc = true
  s.default_subspec = 'Core'

  s.subspec 'Core' do |cs|
    cs.source_files = "Classes/**/*.{h,m}"
    cs.private_header_files = 'Classes/**/*Private.h'
  end

  s.subspec 'Futures' do |fs|
    fs.dependency 'YelpAPI/Core'
    fs.dependency 'BrightFutures', '~> 5.0'

    fs.source_files = "Classes/Futures/*.swift"
  end
end
