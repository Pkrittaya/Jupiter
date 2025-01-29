import Foundation
import Flutter
import UIKit
import WebKit




// Create protocol.
// '@objc' keyword is required. because method call is based on ObjC.
@objc protocol JavaScriptInterface {
//    func tokenReceiver(_ jsonString: String)
//    func chargeReceiver(_ jsonString: String)
    func tokenReceiver(_ jsonString: [String: AnyObject])
    func chargeReceiver(_ jsonString: [String: AnyObject])


}
//// Implement protocol.
//extension FlutterWebView: JavaScriptInterface {
//    func tokenReceiver(_ jsonString: String) {
//        NSLog("JS Interface works! \(jsonString)")
////        if let ca = self.callback {
//
////            ca(jsonString)
////            print("AfterCa ")
////        }
//
//    }
//
//
//    var isSubmitted: JSBool {
//        return JSBool(true)
//    }
//
//    func getErrorMessages(codes: [JSInt]) -> [String] {
//        return codes.map { "message\($0)" }
//    }
//}

//extension Dictionary {
//    var jsonStringRepresentaiton: String? {
//        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
//                                                            options: [.prettyPrinted]) else {
//            return nil
//        }
//
//        return String(data: theJSONData, encoding: .ascii)
//    }
//}


class FlutterWebView: NSObject, FlutterPlatformView,WKNavigationDelegate,WKUIDelegate,JavaScriptInterface{
    
    
//    func chargeReceiver(_ jsonString: String) {
//        NSLog("JS Interface chargeReceiver works! \(jsonString)")
//                if let ca = self.callback {
//
//                    ca(jsonString.description)
//                    print("AfterCa ")
//                }
//    }
//
//    func tokenReceiver(_ jsonString: String) {
//        NSLog("JS Interface tokenReceiver works! \(jsonString)")
//                if let ca = self.callback {
//
//                    ca(jsonString.description)
//                    print("AfterCa ")
//                }
//    }
    
 
    func chargeReceiver(_ jsonString: [String : AnyObject]) {
        NSLog("JS Interface chargeReceiver works! \(jsonString)")
        if let ca = self.callback {
            var jsList = [String]()
            for (key, value) in jsonString {
//                if(key == "saveCard"){
//                    if(value.description == 0.description){
//                        jsList.append("\"\(key)\":\(false)")
//                    }else{
//                        jsList.append("\"\(key)\":\(true)")
//                    }
//                   
//                }else
                if(key == "status" || key == "saveCard"){
                    if(value.description == 0.description){
                        jsList.append("\"\(key)\":\"\(false)\"")
                    }else{
                        jsList.append("\"\(key)\":\"\(true)\"")
                    }
                }else{
                    jsList.append("\"\(key)\":\"\(value)\"")
                }
                
            }
            
            let joined = jsList.joined(separator: ",")
            let result = "{\(joined)}"
           
            print("joined \(result)")
            ca(result)
            print("AfterCa \(result)")
        }
    }

    func tokenReceiver(_ jsonString: [String : AnyObject]) {
        NSLog("JS Interface tokenReceiver works! \(jsonString)")

                                                         
              
        if let ca = self.callback {
            var jsList = [String]()
            for (key, value) in jsonString {
                if(key == "saveCard"){
                    if(value.description == 0.description){
                        jsList.append("\"\(key)\":\(false)")
                    }else{
                        jsList.append("\"\(key)\":\(true)")
                    }
                   
                }else{
                    jsList.append("\"\(key)\":\"\(value)\"")
                }
                
            }
            
            let joined = jsList.joined(separator: ",")
            let result = "{\(joined)}"
           
            print("joined \(result)")
            ca(result)
            print("AfterCa \(result)")
        }
    }
    

    var callback: FlutterResult?
//                      WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler{
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        if (message.name == "tokenReceiver"){
//                   print(" tokenReceiver \(message.body)")
//               }
//        print("didReceiveCall")
//    }
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
//                   {
//                       if navigationAction.targetFrame == nil {
//                           webView.load(navigationAction.request)
//                       }
//
//           print(navigationAction.request.allHTTPHeaderFields)
//
//                       decisionHandler(.allow)
//                   }
           
   
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//       decisionHandler(.allow)
//    }
//    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        print("Error \(error.localizedDescription)")
//    }
//    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//        print ("DID COMMIT")
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print ("FINISHED LOADING")
//    }
    private var _nativeWebView: WKWebView
//    private var _nativeWebView: UIWebView
    private var _methodChannel: FlutterMethodChannel
    private var activityIndicator: UIActivityIndicatorView!
    
    func view() -> UIView {
        return _nativeWebView
    }
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
       
//        _nativeWebView = WKWebView()
//        _nativeWebView.backgroundColor = UIColor.red
        _methodChannel = FlutterMethodChannel(name: "web_view_custom/flutter_web_view_\(viewId)", binaryMessenger: messenger)
        
//        _nativeWebView.allowsBackForwardNavigationGestures = true
        
        
         if #available(iOS 14, *) {
             _nativeWebView = WKWebView(frame: CGRect(x: 0.0, y: 0.0, width: 0.1, height: 0.1))
             super.init()
            let preferences = WKWebpagePreferences()

            preferences.allowsContentJavaScript = true

           

            _nativeWebView.configuration.defaultWebpagePreferences = preferences

//             let contentController = WKUserContentController()
//                     contentController.add(self, name: "KPayment")
//             _nativeWebView.configuration.userContentController = contentController
             
             
//             print("\( String(describing: _nativeWebView.url)) Url Load")
             
            
           
                         let javaScriptController = WKJavaScriptController(name: "KPayment", target: self, bridgeProtocol: JavaScriptInterface.self)
//              Assign javaScriptController.
             _nativeWebView.javaScriptController = javaScriptController
             

        }else {


                 let preferences = WKPreferences()
                    preferences.javaScriptEnabled = true

                    let configuration = WKWebViewConfiguration()
                    configuration.preferences = preferences

            _nativeWebView = WKWebView(frame: CGRect(x: 0.0, y: 0.0, width: 0.1, height: 0.1), configuration: configuration)

            super.init()
//            let javaScriptController = WKJavaScriptController(name: "KPayment", target: self, bridgeProtocol: JavaScriptInterface.self)
//            let contentController = WKUserContentController()
//                    contentController.add(self, name: "KPayment")
//            configuration.userContentController = contentController
            _nativeWebView = WKWebView(frame: CGRect(x: 0.0, y: 0.0, width: 0.1, height: 0.1), configuration: configuration)
            let javaScriptController = WKJavaScriptController(name: "KPayment", target: self, bridgeProtocol: JavaScriptInterface.self)
//              Assign javaScriptController.
_nativeWebView.javaScriptController = javaScriptController
          

////            _nativeWebView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
////
////
        }
//        _nativeWebView = UIWebView(frame: frame)
        
//        super.init()
       
//       _nativeWebView.delegate = self
        _nativeWebView.navigationDelegate = self
        _nativeWebView.uiDelegate = self

        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
         if #available(iOS 13, *) {
            activityIndicator.style = .large
         }
     
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // Auto layout
        let views = ["superview": self._nativeWebView, "indicatorView": activityIndicator]
        let horizontalConstraints = NSLayoutConstraint
            .constraints(withVisualFormat: "H:[superview]-(<=0)-[indicatorView]",
                         options: .alignAllCenterY,
                         metrics: nil,
                         views: views)
        let verticalConstraints = NSLayoutConstraint
            .constraints(withVisualFormat: "V:[superview]-(<=0)-[indicatorView]",
                         options: .alignAllCenterX,
                         metrics: nil,
                         views: views)
        self._nativeWebView.addConstraints(horizontalConstraints)
        self._nativeWebView.addConstraints(verticalConstraints)
        
        _nativeWebView.addSubview(activityIndicator)
        
        // iOS views can be created here
        _methodChannel.setMethodCallHandler(onMethodCall)

        
     
    }
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        let exceptions = SecTrustCopyExceptions(serverTrust)
        SecTrustSetExceptions(serverTrust, exceptions)
        completionHandler(.useCredential, URLCredential(trust: serverTrust));
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        print("webViewDidStartLoad")
        activityIndicator.startAnimating()
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("didFailLoadWithError \(error)")
        self.activityIndicator.stopAnimating()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("webViewDidFinishLoad")
        self.activityIndicator.stopAnimating()
    }

    
    func onMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.callback = result
        
        switch(call.method){
        case "setUrl":
            
            setText(call:call, result:result)
             case "setNewUrl":
            
            setNewUrl(call:call, result:result)
          
        case "getToken":
            let javaScriptController = WKJavaScriptController(name: "KPayment", target: self, bridgeProtocol: JavaScriptInterface.self)
            _nativeWebView.javaScriptController = javaScriptController
//          _nativeWebView.addJavascriptInterface(JSInterface(callback: result), forKey: "KPayment");
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    func setText(call: FlutterMethodCall, result: FlutterResult){
        let url = call.arguments as? String ?? "https://www.google.com/"
        //  url = call.arguments as? String
//        print("URLLoad \(url.description)")
//        let components = NSURLComponents(string:url.description)
        let components = NSURLComponents(string: "https://dev-kpaymentgateway.kasikornbank.com/ui/v2/index.html#mobile-payment/pkey_test_21610v5pRej3WBmTEPYylxNKSZD24D2rgUn2z")!

        components.queryItems = [
            URLQueryItem(name: "submitText", value: "Add Credit Card"),
            URLQueryItem(name: "lang", value: "en"),
            URLQueryItem(name: "callbacktype", value: "app"),
            URLQueryItem(name: "theme", value: "green"),
            URLQueryItem(name: "mid", value: "401240932443001"),
        ]
        print("Component \(components.url!)")
        print("Component \(type(of: components.url!))")

//        let request = NSURL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) as? URL
        let request = components.url
        print("Request \(String(describing: request))")
         if let unwrappedRequest = request {
             let loadRequest = NSURLRequest(url: unwrappedRequest) as URLRequest
             print("URLLoadIn \(loadRequest.description)")
             print("URLLoadUnWrap \(unwrappedRequest.absoluteString)")
           
//                 if let data = try? Data(contentsOf: unwrappedRequest) {
//                     _nativeWebView.load(data, mimeType: "application/pdf", characterEncodingName: "", baseURL: unwrappedRequest)
//                 }else{
//            _nativeWebView.load(loadRequest)
             
             // Call prepareForJavaScriptController before initializing WKWebView or loading page.
      _nativeWebView.prepareForJavaScriptController()
             _nativeWebView.load(loadRequest)
//                 }
             
           
          
         }else{
             print("URLLoadWrong")
         }
       
       
       
    }
    func setNewUrl(call: FlutterMethodCall, result: FlutterResult){
        let url = call.arguments as? String ?? "https://www.google.com/"
        //  url = call.arguments as? String
//        print("URLLoad \(url.description)")
//        let components = NSURLComponents(string:url.description)
        let components = NSURLComponents(string: url)!

        
        print("Component \(components.url!)")
        print("Component \(type(of: components.url!))")

//        let request = NSURL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) as? URL
        let request = components.url
        print("Request \(String(describing: request))")
         if let unwrappedRequest = request {
             let loadRequest = NSURLRequest(url: unwrappedRequest) as URLRequest
             print("URLLoadIn \(loadRequest.description)")
             print("URLLoadUnWrap \(unwrappedRequest.absoluteString)")
           
//                 if let data = try? Data(contentsOf: unwrappedRequest) {
//                     _nativeWebView.load(data, mimeType: "application/pdf", characterEncodingName: "", baseURL: unwrappedRequest)
//                 }else{
//            _nativeWebView.load(loadRequest)
             _nativeWebView.prepareForJavaScriptController()
             _nativeWebView.load(loadRequest)
//                 }
             
           
          
         }else{
             print("URLLoadWrong")
         }
       
       
       
    }
    
}
