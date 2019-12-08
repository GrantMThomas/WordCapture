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
    var filepath:String
    let ip = ImageProcess()
    
    //Load data from file, same logic as HW6
    init(){
        let manager = FileManager.default
        filepath = ""
        if let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first {
            filepath = url.appendingPathComponent("images.plist").path
            
            if manager.fileExists(atPath: filepath){
                if let itemsArray = NSArray(contentsOfFile: filepath){
                    for dict in itemsArray {
                        let itemDict = dict as! [String:String]
                        
                        let imageURL:String = itemDict["image"] ?? "nil"
                        let image = ip.getImage(key: imageURL)
                        let text:String = itemDict["text"] ?? "NA"
                        
                        items.append(imageText(text, image))
                    }
                }
            }
        }
    }
    
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
    func editText(at index: Int, newText: String){
        if(index >= 0 && index < items.count){
            items[index].text = newText
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
