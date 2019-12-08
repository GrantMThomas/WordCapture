//
//  Processor.swift
//  ThomasGrantFinalProject
//
//  Created by Grant Thomas on 12/4/19.
//  Copyright © 2019 Grant Thomas. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseMLCommon
import FirebaseMLVision

class ImageProcess{
    
    let shared = Model.shared
    //Function to extract text from an image, also adds to imageText array
    func imageToText(image: UIImage, callback: @escaping (_ result: String, _ image: UIImage)->()){
        var re = ""
        let vision = Vision.vision()
        let textRecognizer = vision.onDeviceTextRecognizer()
        
        
        let visionImage = VisionImage(image: image)
        
        textRecognizer.process(visionImage) { result, error in
          guard error == nil, let result = result else {
            callback("No text available", image)
            return
          }
            for block in result.blocks {
                for line in block.lines {
                    for element in line.elements {
                        re += element.text
                        re += " "
                    }
                    re += "\n"
                }
            }
            callback(re, image)
        }
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
}


