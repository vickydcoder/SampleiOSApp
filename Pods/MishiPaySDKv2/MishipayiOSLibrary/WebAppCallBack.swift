//
//  WebAppCallBack.swift
//  MishipayiOSLibrary
//
//  Created by Vivek Garg on 06/07/21.
//

import Foundation
public protocol WebAppCallBack {
    func transactionResult(orderId:String, transactionStatus:String, transactionAmount:Double)
}

