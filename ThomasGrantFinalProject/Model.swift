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
    
    
    func textFromImage(image: UIImage, callback: @escaping (_ result: String)->()){
        
        
    }
    
    //Function to extract text from an image, also adds to imageText array
    //Makes call to api
    func readText(image: UIImage, callback: @escaping (_ result: String)->()){
        //Resize the image
        let i1 = resizeImage(image: image, newWidth: 400)!
        //Set up the URL request
        var request = URLRequest(url: URL(string: "https://api.ocr.space/parse/image")!)
        let imageData = i1.pngData()!
        //Encode image
        let base64Image = imageData.base64EncodedString(options: [])
        request.httpMethod = "POST"
        let line = ("data:image/jpg;base64," + base64Image).addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        let postString = "apikey=" + Credentials.APIKEY + "&base64Image=" + line
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        //Set up URL session
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response{
                print(response)
            }
            if let data = data {
                print(data)
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    print(json)
                    if let dictionary = json as? [String:Any]{
                        print("First")
                        if let result = dictionary["ParsedResults"] as? [[String:Any]]{
                            
                            print("Second")
                            if let finalString = result[0]["ParsedText"] as? String{
                                //Successful reading, callback here
                                print("FINAL STRING: " + finalString)
                                self.items.append(imageText(finalString, image))
                            }
                        }
                    }
                }
                catch{
                    print(error)
                }
            }
            }.resume()
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
