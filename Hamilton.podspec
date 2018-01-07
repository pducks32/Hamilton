#
# Be sure to run `pod lib lint Hamilton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Hamilton'
  s.version          = '1.0.2'
  s.summary          = 'Helps manipulates quaternions and vectors.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Helps manipulate quaternions and vectors wherever you may find them in the wild.
                       DESC

  s.homepage         = 'https://github.com/pducks32/Hamilton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Patrick Metcalfe' => 'git@patrickmetcalfe.com' }
  s.source           = { :git => 'https://github.com/pducks32/Hamilton.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/pducks32'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.11'

  s.source_files = 'Sources/Hamilton/**/*'
  
  # s.resource_bundles = {
  #   'Hamilton' => ['Hamilton/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
