//
//  ViewController.swift
//  ThomasGrantFinalProject
//
//  Created by Grant Thomas on 12/1/19.
//  Copyright © 2019 Grant Thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        //Set up the image picker
        let ip = UIImagePickerController()
        ip.delegate = self
        ip.allowsEditing = true
        ip.mediaTypes = ["public.image"]
        ip.sourceType = .camera
        
        //Make sure source type is avalable (Mainly so it doesn't crash in simulator)
        
        
        
    }
    
    @IBAction func libraryButtonPressed(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //This function makes it more convenient to add an alert
    func alert(input: String){
        let alert = UIAlertController(title: "Word Capture", message: input, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}

