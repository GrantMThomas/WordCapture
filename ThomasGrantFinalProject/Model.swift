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
                        print("Key: " + imageURL)
                        let image = ImageProcess.getImage(key: imageURL)
                        let text:String = itemDict["text"] ?? "NA"

                        //Appending the array without adding to the file system since already exists
                        items.append(imageText(text, image, key: imageURL))
                    }
                }
            }
        }
    }
    
    func addImage(image: UIImage, text: String){
        //Add image to to file system
        let key = "\(NSDate().timeIntervalSince1970)"
        ImageProcess.placeImage(key: key, image: image)
        
        //Add image to local array
        items.append(imageText(text, image, key: key))
        
        save()
    }
    
    func getImageText(at index: Int)->imageText? {
        if index >= 0 && index < items.count{
            return items[index]
        }
        return nil
    }
    func removeImage(at index: Int){
        if index >= 0 && index < items.count{
            
            //Remove image from file system
            ImageProcess.removeImage(key: items[index].key)
            
            //Remove from local array
            items.remove(at: index)
            
            save()
        }
    }
    func editText(at index: Int, newText: String){
        if(index >= 0 && index < items.count){
            items[index].text = newText
            
            save()
        }
    }
    
    //Save to array, just saves key and text
    private func save(){
        var itemsArray = [[String:String]]()
        
        for iT in items {
            let dict = ["image" : iT.key, "text" : iT.text]
            itemsArray.append(dict)
        }
        (itemsArray as NSArray).write(toFile: filepath, atomically: true)
    }
    
    
}



//Struct to hold image and text items in array
struct imageText{
    var text: String
    var image: UIImage
    var key: String
    init(_ text: String, _ image: UIImage, key: String){
        self.text = text
        self.image = image
        self.key = key
    }
}
