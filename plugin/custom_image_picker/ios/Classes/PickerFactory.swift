//
//  PickerFactory.swift
//  custom_image_picker
//
//  Created by Supadech Santivittayarom on 6/11/2566 BE.
//

import Foundation
import Flutter
import UIKit

@available(iOS 14.0, *)
class PickerFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FlutterPicker(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}
