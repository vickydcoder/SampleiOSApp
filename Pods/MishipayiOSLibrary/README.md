# MishipayiOSLibrary

MishiPay iOS Library written in Swift for retailers and partners to provide MishiPay web as a service to iOS Host Apps.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Requirements

- iOS 14.3+ 
- Xcode 12.5.1+
- Swift 5.3.2

## Installation 
A step by step series of installing Mishipay-Library


### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To view MishipayiOSLibrary on cocoapods.org click [here](https://cocoapods.org/pods/MishipayiOSLibrary)

## Initialize SDK

##### How to integrate SDK
Step 1. To integrate MishipayiOSLibrary into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'MishipayiOSLibrary', '2.0.1'
```
##### Note:- Make Sure that you are adding following source in your podfile to install the sdk 
```ruby
source 'https://github.com/vickydcoder/MishipayiOSLibrary.git'
source 'https://github.com/CocoaPods/Specs.git'
```
For reference, see example [podfile](https://github.com/vickydcoder/SampleiOSApp/blob/master/Podfile)

Step 2. Do ```pod install --repo-update ```

Step 3. Add keys to `info.plist ` 👇🏻

MishiPayiOSLibrary requires the use of camera and microphone. Please add the respective permissions to your info.plist file. 

1. `Camera`: The camera is used for scanning barcodes on items.

```
 NSCameraUsageDescription
```

1. `Microphone`: The microphone is used as dependency for accessing camera.. 
```
 NSMicrophoneUsageDescription
```
For reference, see example [info.plist](https://github.com/vickydcoder/SampleiOSApp/blob/master/SampleiOSApp/Info.plist)

## Invoking the SDK

##### How to invoke the SDK

import MishipayiOSLibrary in your required view controller and then invoke the library by passing values to the following `configurable parameters`. All are mandatory to be passed.
```ruby
isUserLoginRequired: String,
isBasketTransferNeeded: String,
isPaymentAllowed:String,
userEmail: String,
sessionId: String,
lat: String,
long: String,
```
For launching/Presenting the SDK 👇🏻
```ruby
 let web = WebAppConfig(
            isUserLoginRequired: "no",
            isBasketTransferNeeded: "yes",
            isPaymentAllowed:"no",
            userEmail: "vivek@mishipay.com",
            sessionId: "ABCDEF",
            lat: "43.3178635",
            long: "-2.9764437",
            openController:self,
            webAppCallback:self)
web.startShoppingCart()
```
##### Note:- Make Sure that you are implementing WebAppCallBack's transactionResult before invoking the sdk 
```ruby
  Step 1. class ViewController: UIViewController ,WebAppCallBack{...}
  
  Step 2. func transactionResult(orderId:String, transactionStatus:String, transactionAmount:Double) {
            print("orderId\(orderId)")
            print("transactionStatus\(transactionStatus)")
            print("transactionAmount\(transactionAmount)")
          }
```
For reference see [example](https://github.com/vickydcoder/SampleiOSApp/blob/master/SampleiOSApp/ViewController.swift) 

## Special Cases

##### 1. Basket Transfer

When isBasketTransferNeeded is set to `yes` then libraray will show Order QR Code on it's QrCodePreviewViewController.

##### 2. Payment

1. When isPaymentAllowed is set to `yes` then payment callback with recieve transactionStatus as  transactionStatus `SUCCESS` with orderID from Mishipay web and total amount paid as `transactionAmount`
2. When isPaymentAllowed is set to `no` then payment callback with recieve transactionStatus as  transactionStatus `PAY_IN_HOST_APP` with orderID from Mishipay web and total amount paid as `transactionAmount` to handle payments in Host App.

## Sample iOS App utilizing this library

https://github.com/vickydcoder/SampleiOSApp

## Built With

* [Xcode](https://developer.apple.com/xcode/) - Apple IDE for iOS, MacOS, WatchOS
* [Swift](https://developer.apple.com/swift/) - Programming Language
* [Cocoapods](https://cocoapods.org/) - Application level dependency manager 

## Authors

* **Vivek Garg**  - [MishiPay Ltd](https://mishipay.com/)

## License

This project is licensed under MIT license

`Copyright 2021 | All Rights Reserved by MishiPay Ltd.`
