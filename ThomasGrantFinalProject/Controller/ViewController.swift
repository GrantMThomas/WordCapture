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
    var ip:UIImagePickerController!
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        //Make sure source type is avalable (Mainly so it doesn't crash in simulator)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            //Set up the image picker
            ip = UIImagePickerController()
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
            ip = UIImagePickerController()
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
        
    }
    
    
    //This function makes it more convenient to add an alert
    func alert(_ input: String){
        let alert = UIAlertController(title: "Word Capture", message: input, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            let p = ImageProcess()
            p.imageToText(image: image, callback: printResult)
            //print(p.imageToText(image: image))
            ip.dismiss(animated: true, completion: nil)
        }
    }
    func printResult(_ input: String){
        print(input)
    }


}

