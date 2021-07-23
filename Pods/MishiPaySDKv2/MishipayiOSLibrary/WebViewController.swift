//
//  WebViewController.swift
//  MishipayiOSLibrary
//
//  Created by Vivek Garg on 06/07/21.
//

import UIKit
import WebKit
class WebViewController: UIViewController ,WKNavigationDelegate, WKUIDelegate{
    var webView: WKWebView!
    var isUserLoginRequired = ""
    var isBasketTransferNeeded = ""
    var isPaymentAllowed = ""
    var userEmail = ""
    var sessionId = ""
    var lat = ""
    var long = ""
    
    var webAppCallBack:WebAppCallBack? = nil

    override func viewDidLoad() {
      super.viewDidLoad()
      initialization()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
             sendConfig()
      }
    private func initialization(){
        let urlVal = URL(string: "https://sdk.mishipay.com/locate?r_lat=" + lat + "&r_long=" + long)
        
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        
        let configurations = WKWebViewConfiguration()
        configurations.defaultWebpagePreferences = preferences
        configurations.allowsInlineMediaPlayback = true
        
        let controller = WKUserContentController()
        controller.add(self, name: "base64EncodedQrPNG")
        controller.add(self, name: "transactionResult")
        
        configurations.userContentController = controller
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let sh = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let width = self.view.frame.width
        let height = self.view.frame.height-44-sh
        
        webView = WKWebView(frame: CGRect(x: 0, y: 44+sh, width: width, height: height), configuration: configurations)
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: urlVal!))
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        self.view.addSubview(webView)
        
        let navigationBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: sh, width: width, height: 44))
        self.view.addSubview(navigationBar)
        navigationItem.title = "Scan & Go"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: ImageProvider.backArrow(), style: .done, target: self, action: #selector(didTapBack))
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    private func sendConfig(){
        let dict:[String:String] = ["isUserLoginRequired":isUserLoginRequired,"isBasketTransferNeeded":isBasketTransferNeeded, "isPaymentAllowed": isPaymentAllowed, "userEmail":userEmail, "sessionId":sessionId]
        guard let jsonData = try? JSONEncoder().encode(dict),
        let jsString = String(data : jsonData, encoding: .utf8) else {
        return
        }
        let jsCall = "window.configurationsFromHostApp("+jsString+")"
        webView.evaluateJavaScript(jsCall, completionHandler: nil)
    }
   
    @objc private func didTapBack(){
        let alert = UIAlertController(title: "Confirm", message: "Are you sureyou want to exit?", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.cancel, handler: { UIAlertAction in
            self.dismiss(animated: true, completion: nil)
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
   
}
extension WebViewController : WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        if(message.name == "base64EncodedQrPNG"){
            if(webAppCallBack != nil){
                let newViewController = QrCodePreviewViewController()
                newViewController.imageBase64String = "\(message.body)".replacingOccurrences(of: "data:image/png;base64,", with: "")
                newViewController.modalPresentationStyle = .fullScreen
                newViewController.webViewController = self
                self.present(newViewController, animated: true, completion: nil)}
        } else if(message.name == "transactionResult"){
            if(webAppCallBack != nil){
                print("Meesage Body for transactions\(message.body)")
                guard let transactionResult = message.body as? [String : AnyObject] else {
                           return
                       }
                guard let id = transactionResult["id"] else {
                    return
                }
                guard let status = transactionResult["status"] else {
                    return
                }
                guard let amount = transactionResult["amount"] else {
                    return
                }
                webAppCallBack?.transactionResult(orderId: id as! String, transactionStatus: status as! String, transactionAmount: amount as! Double)
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}

