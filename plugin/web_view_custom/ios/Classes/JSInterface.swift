//
//  JSInterface.swift
//  JSInterface
//
//  Created by Kem on 9/12/15.
//  Copyright © 2015 Kem. All rights reserved.
//

import Foundation
import JavaScriptCore
import UIKit
import Flutter

@objc protocol MyExport : JSExport
{
 

     func tokenReceiver(_ jsonString : String)
     func chargeReceiver(_ jsonString : String)
    func sayGreeting(_ message: String, _ name: String)
    func anotherSayGreeting(_ message: String, name: String)
    func showDialog(_ title: String, _ message : String)
}


class JSInterface : NSObject, MyExport
{    var callback: FlutterResult?

  init(callback: FlutterResult?) {
    self.callback = callback
  }
    func tokenReceiver(_ jsonString: String) {
        print("JS Interface works! \(jsonString)")
        if let ca = self.callback {
            ca(jsonString)
            print("AfterCa ")
        }
       
    }
    func chargeReceiver(_ jsonString: String) {
        print("JS Interface ChargeReceiver works! \(jsonString)")
        if let ca = self.callback {
            ca(jsonString)
            print("After ChargeReceiver ")
        }
       
    }

    
    func sayGreeting(_ message: String, _ name: String)
    {
        print("sayGreeting: \(message): \(name)")
    }
    
    func anotherSayGreeting(_ message: String, name: String)
    {
        print("anotherSayGreeting: \(message): \(name)")
    }

    func showDialog(_ title: String, _ message : String)
    {
        DispatchQueue.main.async(execute: {
            UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK").show()
        })
    }
}
