//
//  ImageCell.swift
//  custom_image_picker
//
//  Created by Supadech Santivittayarom on 7/11/2566 BE.
//

import Foundation
import SwiftGridView
//class ImageCell:SwiftGridCell{
////var uiImage: UIImage
//    override var reuseIdentifier: String? {
//        return String(describing: ImageCell.self)
//    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
//    
//    
//    
//   
//}

import UIKit
class ImageCell: SwiftGridCell {

    var myLabel = UILabel()
    var uiImage = UIImage()

    var width = UIScreen.main.bounds.width/4

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        myLabel.frame = CGRect(x: 0, y: 0, width: width, height: width)
       
    }
        override var reuseIdentifier: String? {
            return String(describing: ImageCell.self)
        }
        override func prepareForReuse() {
            super.prepareForReuse()
        }
        
}
