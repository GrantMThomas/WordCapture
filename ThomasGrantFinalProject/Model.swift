//
//  Model.swift
//  ThomasGrantFinalProject
//
//  Created by Grant Thomas on 12/1/19.
//  Copyright © 2019 Grant Thomas. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileVision

class Model {
    
    public static let shared = Model()
    var items = [imageText]()
    
    //Function to extract text from an image, also adds to imageText array
    func imageToText(image: UIImage)->String{
        var result = ""
        
        let textDetector = GMVDetector(ofType: GMVDetectorTypeText, options: nil)
        let features:[GMVTextBlockFeature] = (textDetector?.features(in: image, options: nil)!)! as! [GMVTextBlockFeature]
        
        for element in features {
            for line in element.lines{
                for text in line.elements{
                    result += text.value
                    result += " "
                }
            }
        }
        items.append(imageText(result, image))
        return result
    }
    
    
    
    //This function wasn't invented by me, I used it for a previous project
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    //Struct to hold image and text items in array
    struct imageText{
        var text: String
        var image: UIImage
        init(_ text: String, _ image: UIImage){
            self.text = text
            self.image = image
        }
    }
}
