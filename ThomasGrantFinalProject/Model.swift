//
//  Model.swift
//  ThomasGrantFinalProject
//
//  Created by Grant Thomas on 12/1/19.
//  Copyright © 2019 Grant Thomas. All rights reserved.
//

import Foundation
import UIKit


class Model {
    
    public static let shared = Model()
    var items = [imageText]()
    
    func addImage(image: UIImage, text: String){
        items.append(imageText(text, image))
    }
    
    func getImageText(at index: Int)->imageText? {
        if index >= 0 && index < items.count{
            return items[index]
        }
        return nil
    }
    func removeImage(at index: Int){
        if index >= 0 && index < items.count{
            items.remove(at: index)
        }
    }
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
