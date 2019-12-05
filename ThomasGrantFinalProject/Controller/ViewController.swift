//
//  ViewController.swift
//  ThomasGrantFinalProject
//
//  Created by Grant Thomas on 12/1/19.
//  Copyright © 2019 Grant Thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let model = Model.shared
    
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        //Make sure source type is avalable (Mainly so it doesn't crash in simulator)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            //Set up the image picker
            let ip = UIImagePickerController()
            ip.delegate = self
            ip.allowsEditing = true
            ip.mediaTypes = ["public.image"]
            ip.sourceType = .camera
            present(ip, animated: true, completion: nil)
        }
        else{
            alert("Camera not available on device, please select from library")
        }
        
    }
    
    @IBAction func libraryButtonPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            //Set up the image picker
            let ip = UIImagePickerController()
            ip.delegate = self
            ip.allowsEditing = true
            ip.mediaTypes = ["public.image"]
            ip.sourceType = .photoLibrary
            present(ip, animated: true, completion: nil)
        }
        else{
            alert("Photo library is unavailable, please give permission to access")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //This function makes it more convenient to add an alert
    func alert(_ input: String){
        let alert = UIAlertController(title: "Word Capture", message: input, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            print(model.imageToText(image: image))
        }
    }


}

