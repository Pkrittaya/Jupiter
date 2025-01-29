//
//  FlutterPicker.swift
//  custom_image_picker
//
//  Created by Supadech Santivittayarom on 6/11/2566 BE.
//

import Foundation
import Flutter
import UIKit
import SwiftGridView
import PhotosUI
import SwiftUI

@available(iOS 14, *)
struct ContentView: View {
   
    
    let width = (UIScreen.main.bounds.width-40)/3
    
//    var pickerImage:PickerImage
    @State var _imageSelected:String = ""
    @State var callback:FlutterResult?
//    @State var eventChannel:FlutterEventChannel
    
    //        @State var _eventSink:FlutterEventSink?
    
    let columns = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
    ]
    init(callback: FlutterResult?) {
        self.callback = callback
//        self.pickerImage = pickerImage
        print("InitContentView")
        
        
       checkPermission()
        
        
    }


    var body: some View {
//        Button {
//                            
////                                checkPermission()
//                            
//                        } label: {
//                            
//                            Text("select Photo")
//                            
//                        }
        ZStack {
            Color.white
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    let fetchOptions = PHFetchOptions()
                    let data = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                    let collection = PHFetchResultCollection(fetchResult: data)
                    
    //                    print("Limited Collection \(collection.count)")
    //                    print("Limited \(data.count)")
    //                    print("Limited \(data.description)")
    //                   let manager = PHImageManager.default()
    //                   let requestImageOption = PHImageRequestOptions()
                
                    ForEach(collection, id: \.self) { image in
                    
                                                Image(uiImage: getAssetThumbnail(asset: image))
                                                
                                                .resizable()
                            
                                                    .frame(minWidth: width, maxWidth: width, minHeight: width, maxHeight: width)
    //                                                    .aspectRatio(1, contentMode: .fit)
                                                    .background(Color.blue)
                                                    .onTapGesture {
                                                        print("Tap Image \(image.localIdentifier)")
                                                        _imageSelected = image.localIdentifier
                                                        
                                                        let key = "ImageClick"
    //                                                    pickerImage.imageId = image.localIdentifier
                                                        let defaults = UserDefaults.standard
                                                        defaults.set(
                                                            image.localIdentifier,
                                                            forKey: key
                                                        )
            
                                                            print("SinkDataSuccess")
                                                    
                                                    }

                    }
                }
                .padding(.horizontal)
                
            }
            .frame(maxHeight:.infinity)
        }

    }
    
     func checkPermission() {

//             _imageAssets.removeAll()
         
            let accessLevel : PHAccessLevel = .readWrite
           let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus(for: accessLevel)
        print("AuthorizeStatus \(photoAuthorizationStatus)")
         
           switch photoAuthorizationStatus {

           case .authorized:

               print("Access is granted by user")

//                   isPickerShowing = true

           case .notDetermined:

               PHPhotoLibrary.requestAuthorization({

                   (newStatus) in

                   print("status is \(newStatus)")

                   if newStatus ==  PHAuthorizationStatus.authorized {

                       /* do stuff here */

//                           isPickerShowing = true

                   }

               })

               print("It is not determined until now")

           case .restricted:

               // same same

               print("User do not have access to photo album.")

           case .denied:

               // same same

               print("User has denied the permission.")

           case .limited:

               print("User Limited Show Photo.")
//                   isPickerShowing = true
//                   let fetchOptions = PHFetchOptions()
//                   let data = PHAsset.fetchAssets(with: .image, options: fetchOptions)
//                   let collection = PHFetchResultCollection(fetchResult: data)
//                   print("Limited Collection \(collection.count)")
//                   print("Limited \(data.count)")
//                   print("Limited \(data.description)")
//                   let manager = PHImageManager.default()
//                   let requestImageOption = PHImageRequestOptions()
//                   for col in collection {
//                       print("Limited LoopCol \(col.localIdentifier)")
//
//
//                       print("Limited LoopCol \(_imageAssets.count)")
//                   }
//                   data.enumerateObjects({ asset, index, stop in
//                       //your code
//                       let manager = PHImageManager.default()
//                       let option = PHImageRequestOptions()
////                       var thumbnail = UIImage()
//                       option.isSynchronous = true
//                       manager.requestImage(for: asset, targetSize: CGSize(width: width, height: 200), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
////                               thumbnail = result!
//                           self._imageAssets.append(result!)
//                           print("Limited Request \(self._imageAssets.count)")
//                           print("Limited Request \(self._imageAssets.description)")
//                           print("Limited Request \(result!)")
//                       })
////                       imgs.append(getAssetThumbnail(asset: asset))
//
//                       print("Limited Loop\(self._imageAssets.count)")
//                   })
//                   print("Limited After \(_imageAssets.count)")
//                   self._imageAssets = imgs
//                   for col in collection {
//                       self._imageAssets.append(getAssetThumbnail(asset: PHAsset()))
//                   }
//
           
           @unknown default:

               print("User Unknow")

           }

            

       }
    
    
    struct PHFetchResultCollection: RandomAccessCollection, Equatable {

        typealias Element = PHAsset
        typealias Index = Int

        let fetchResult: PHFetchResult<PHAsset>

        var endIndex: Int { fetchResult.count }
        var startIndex: Int { 0 }

        subscript(position: Int) -> PHAsset {
            fetchResult.object(at: fetchResult.count - position - 1)
        }
    }
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: width, height: width), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
        })
        return thumbnail
    }
    

}
//@available(iOS 14.0, *)
//class PickerImage: ObservableObject {
//
//    @Published var imageId: String = ""
//
//    func setImageid(imgId:String) {
//        imageId = imgId
//    }
//}

@available(iOS 14.0, *)
class FlutterPicker: NSObject, FlutterPlatformView{
    
    var width = UIScreen.main.bounds.width/4
    
  
//    var pickerImage:PickerImage
    
   
    
   
    var callback: FlutterResult?

//    private var _btn: UIButton
   
     var  _imageAssets : [UIImage] = []
//    private var _nativeWebView: UIWebView
    private var _uiView: UIView
    private var _methodChannel: FlutterMethodChannel
//    var _eventChannel: FlutterEventChannel
    
    private var activityIndicator: UIActivityIndicatorView!
    
    func view() -> UIView {
        return _uiView
    }
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
       
//        _nativeWebView = WKWebView()
//
       
        _uiView = UIView()
       
        
        // 3
        // Create and activate the constraints for the swiftui's view.
      
        
        // 4
        // Notify the child view controller that the move is complete.
//        vc.didMove(toParent: self)
       
//        _btn = UIButton()
//        _btn.setTitle("✸✸✸✸✸✸✸✸", for: .normal)
//        _btn.setTitleColor(.blue, for: .normal)
////        _btn.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
//        _btn.backgroundColor = UIColor.green
//       
       
        _methodChannel = FlutterMethodChannel(name: "custom_image_picker/flutter_picker_\(viewId)", binaryMessenger: messenger)
       
//         _eventChannel = FlutterEventChannel(name: "PickerHandler", binaryMessenger: messenger)
       
//        pickerImage = PickerImage()
        
        
        super.init()

        _methodChannel.setMethodCallHandler(onMethodCall)
        
//        _btn.addTarget(self, action: #selector(test), for: .touchUpInside)
        let contentView = ContentView(callback: callback)
        let vc = UIHostingController(rootView: contentView)
        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        _uiView.window?.rootViewController = vc
        _uiView.addSubview(swiftuiView)

        NSLayoutConstraint.activate([
            swiftuiView.topAnchor.constraint(equalTo: view().topAnchor, constant: 0),
            swiftuiView.bottomAnchor.constraint(equalTo: view().bottomAnchor, constant: 0),
            swiftuiView.leadingAnchor.constraint(equalTo: view().leadingAnchor, constant: 0),
            swiftuiView.trailingAnchor.constraint(equalTo: view().trailingAnchor, constant: 0),
           
        ])
       
        
       // The UIViewController from which to present the picker.
       
//        let fetchOptions = PHFetchOptions()
//               let data = PHAsset.fetchAssets(with: .image, options: fetchOptions)
//               print("Change \(_imageAssets.count)")
//        _gridView.delegate = self
//        _gridView.dataSource = self
//        _gridView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: ImageCell.reuseIdentifier())
        // iOS views can be created here
        
        
        
     
    }
   
   

    func onMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.callback = result
        
        switch(call.method){
//        case "setUrl":
//            
//           
//             case "setNewUrl":
//

           
////          _nativeWebView.addJavascriptInterface(JSInterface(callback: result), forKey: "KPayment");
        default:
            result(FlutterMethodNotImplemented)
        }
    }
   
       
    
   
       
       
       
    
    
}

@available(iOS 14.0, *)
public class NativeStreamHandler: NSObject,FlutterStreamHandler {
   
    var eventSink: FlutterEventSink?
//    var test: String = ""
//    var pickerImage:PickerImage
//    init( pickerImage: PickerImage) {
//    
//        self.pickerImage = pickerImage
//    
//    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
//        print("TestData \(test)")
//        self.eventSink?(test)
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            let randomNumber = Int.random(in: 1...20)
            print("Number: \(randomNumber)")
//            events(self.pickerImage.imageId)
            let key = "ImageClick"
            let defaults = UserDefaults.standard
            let imageId = defaults.string(forKey:key)
            print("Number: \((imageId != "" && imageId != nil))")
            if imageId != nil {
              
                events(imageId)
                print("NeedStop: ")
                defaults.removeObject(forKey: key)
//                defaults.set(
//                    nil,
//                    forKey: key
//                )
                timer.invalidate()
            }
        }
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
    
}
