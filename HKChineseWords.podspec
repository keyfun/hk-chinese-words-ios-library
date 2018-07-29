#
# Be sure to run `pod lib lint HKChineseWords.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HKChineseWords'
  s.version          = '0.1.6'
  s.summary          = 'A library to get Hong Kong Chinese Words stoke input sequence.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A library to get Hong Kong Chinese Words stoke input sequence.
Source: http://www.edbchinese.hk/lexlist_ch/
                       DESC

  s.homepage         = 'https://github.com/keyfun/hk-chinese-words-ios-library'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Key Fun' => 'keyfun.hk@gmail.com' }
  s.source           = { :git => 'https://github.com/keyfun/hk-chinese-words-ios-library.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'HKChineseWords/Classes/**/*'
  
end
