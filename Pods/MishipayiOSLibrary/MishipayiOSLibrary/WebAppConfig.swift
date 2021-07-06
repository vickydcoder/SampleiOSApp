//
//  WebAppConfig.swift
//  MishipayiOSLibrary
//
//  Created by Vivek Garg on 06/07/21.
//

import UIKit
import Foundation
public class WebAppConfig{
    var isUserLoginRequired = ""
    var isBasketTransferNeeded = ""
    var isPaymentAllowed = ""
    var userEmail = ""
    var sessionId = ""
    var lat = ""
    var long = ""
    var openController : UIViewController? = nil
    var webAppCallBack : WebAppCallBack? = nil
    public init(isUserLoginRequired:String,
                isBasketTransferNeeded:String,
                isPaymentAllowed:String,
                userEmail: String,
                sessionId: String,
                lat: String,
                long: String,
                openController:UIViewController,
                webAppCallback:WebAppCallBack) {
    self.isUserLoginRequired = isUserLoginRequired
    self.isBasketTransferNeeded = isBasketTransferNeeded
    self.isPaymentAllowed = isPaymentAllowed
    self.userEmail = userEmail
    self.sessionId = sessionId
    self.lat = lat
    self.long=long
    self.openController = openController
    self.webAppCallBack = webAppCallback
    }
    public func startShoppingCart()  {
        let webViewController = WebViewController()
        webViewController.isUserLoginRequired = self.isUserLoginRequired
        webViewController.isBasketTransferNeeded = self.isBasketTransferNeeded
        webViewController.isPaymentAllowed = self.isPaymentAllowed
        webViewController.userEmail = self.userEmail
        webViewController.sessionId = self.sessionId
        webViewController.lat = self.lat
        webViewController.long = self.long
        webViewController.webAppCallBack = self.webAppCallBack
        webViewController.modalPresentationStyle = .fullScreen
        openController?.present(webViewController, animated: true, completion: nil)
}
}

