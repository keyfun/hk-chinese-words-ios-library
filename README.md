# hk-chinese-words-ios-library
香港小學學習字詞表 iOS Library

[![CI Status](http://img.shields.io/travis/keyfun/hk-chinese-words-ios-library.svg?style=flat)](https://travis-ci.org/keyfun/hk-chinese-words-ios-library)
[![Version](https://img.shields.io/cocoapods/v/HKChineseWords.svg?style=flat)](http://cocoapods.org/pods/HKChineseWords)
[![License](https://img.shields.io/cocoapods/l/HKChineseWords.svg?style=flat)](http://cocoapods.org/pods/HKChineseWords)
[![Platform](https://img.shields.io/cocoapods/p/HKChineseWords.svg?style=flat)](http://cocoapods.org/pods/HKChineseWords)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

HKChineseWords is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HKChineseWords'
```

## Usage

```swift
HKChineseWords.sharedInstance.getImages(word) { (images:Array<UIImage>, error:Error?) in
            self.setImages(images)
        }
```

Official Website
http://www.edbchinese.hk/lexlist_ch/

## Author

KeyFun, keyfun.hk@gmail.com

## License

HKChineseWords is available under the MIT license. See the LICENSE file for more info.
