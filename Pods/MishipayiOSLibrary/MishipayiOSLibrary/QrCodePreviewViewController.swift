//
//  QrCodePreviewViewController.swift
//  MishipayiOSLibrary
//
//  Created by Vivek Garg on 06/07/21.
//

import UIKit

class QrCodePreviewViewController: UIViewController {
    
    var imageBase64String = ""
    var webViewController: WebViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func initialization(){
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let sh = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let width = self.view.frame.width
        let height = self.view.frame.height-sh
        
        let view = UIView(frame: CGRect(x: 0, y: sh, width: width, height: height))
        view.backgroundColor = .white
        
        var qrCodeSize = height/2
        if(qrCodeSize>width){
            qrCodeSize = width - 44
        }
        
        let myImageView:UIImageView = UIImageView()
        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
        myImageView.frame.size.width = qrCodeSize
        myImageView.frame.size.height = qrCodeSize
        myImageView.center = self.view.center
            
        view.addSubview(myImageView)
        let newImageData = Data(base64Encoded: imageBase64String)
        if let newImageData = newImageData {
            myImageView.image = UIImage(data: newImageData)
        }
         
        self.view.addSubview(view)
        
        let navigationBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: sh, width: width, height: 44))
        self.view.addSubview(navigationBar)
        navigationItem.title = "Order Qr Code"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: ImageProvider.backArrow(), style: .done, target: self, action: #selector(didTapBack))
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    @objc private func didTapBack(){
        let alert = UIAlertController(title: "Confirm", message: "Are you sureyou want to exit?", preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.cancel, handler: { UIAlertAction in
            self.dismiss(animated: false) {
                self.webViewController?.dismiss(animated: false, completion: nil)
            }
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

