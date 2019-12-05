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
