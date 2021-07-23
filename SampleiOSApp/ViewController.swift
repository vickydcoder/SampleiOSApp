//
//  ViewController.swift
//  SampleiOSApp
//
//  Created by Vivek Garg on 06/07/21.
//

import UIKit
import MishiPaySDKv2
class ViewController: UIViewController ,WebAppCallBack{
  
    
    @IBOutlet weak var textView: UITextView!
    func transactionResult(orderId:String, transactionStatus:String, transactionAmount:Double) {
        print("orderId\(orderId)")
        print("transactionStatus\(transactionStatus)")
        print("transactionAmount\(transactionAmount)")
        textView.text = "Payment \(transactionStatus) with order id \(orderId) and amount \(transactionAmount)"
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func scanGoNPA(_ sender: Any) {
        // Payment Not Allowed (Pay in Host APP)
        startWebActivity(isBasketTransferNeeded: "no", isPaymentAllowed: "no", lat: "26.0742392", long: "-80.1527909")
    }
    @IBAction func scanGoPA(_ sender: Any) {
        // Payment Allowed
        startWebActivity(isBasketTransferNeeded: "no", isPaymentAllowed: "yes", lat: "26.0742392", long: "-80.1527909")
    }
    @IBAction func scanGo(_ sender: Any) {
        // BT
        startWebActivity(isBasketTransferNeeded: "yes", isPaymentAllowed: "no", lat: "43.3178635", long: "-2.9764437")
        
    }
    
    func startWebActivity(isBasketTransferNeeded: String, isPaymentAllowed: String, lat: String,long: String){
        let web = WebAppConfig(
            isUserLoginRequired: "no",
            isBasketTransferNeeded: isBasketTransferNeeded,
            isPaymentAllowed:isPaymentAllowed,
            userEmail: "vivek@mishipay.com",
            sessionId: "ABCDEF",
            lat: lat,
            long: long,
            openController:self,
            webAppCallback:self)
        web.startShoppingCart()
}

}

