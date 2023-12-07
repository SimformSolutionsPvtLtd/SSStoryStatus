#
# Be sure to run `pod lib lint SSStoryStatus.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'SSStoryStatus'
    s.version          = '0.0.1'
    s.summary          = 'Integrate profile listing and story view with customizable components.'
    s.readme           = 'https://github.com/SimformSolutionsPvtLtd/SSStoryStatus/blob/master/README.md'
  
    s.description      = <<-DESC
    SSStoryStatus is a versatile and intuitive SwiftUI library designed to effortlessly display user lists and seamlessly showcase their captivating stories.
    This library empowers developers to effortless integration of user listings with story viewing functionality.
    The library provides complete control over view components for UI customization.

    ## Features
    
    - Image & Video stories
    - Customizable componenet with styles
    - Built-in caching support
    - Callback on story seen
    - Reaction emojis and message
    - Story caption support
                         DESC
  
    s.homepage         = 'https://github.com/SimformSolutionsPvtLtd/SSStoryStatus'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Krunal Patel' => 'krunal.patel@simformsolutions.com' }
    s.source           = { :git => 'https://github.com/SimformSolutionsPvtLtd/SSStoryStatus.git', :tag => s.version.to_s }
  
    s.ios.deployment_target = '17.0'
    s.swift_versions        = ['5.9']
  
    s.source_files      = 'Sources/**/*.{swift}'
    s.resource_bundles  = {
      'SSStoryStatus' => ['Sources/SSStoryStatus/Resources/**/*']
    }

  end
  