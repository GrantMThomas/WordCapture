//
//  ViewController.swift
//  ThomasGrantFinalProject
//
//  Created by Grant Thomas on 12/1/19.
//  Copyright © 2019 Grant Thomas. All rights reserved.
//  gmthomas@usc.edu

import UIKit
import CropViewController
import GoogleMobileAds

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate, GADBannerViewDelegate {
    
    let model = Model.shared
    var ip:UIImagePickerController!
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        //Make sure source type is avalable (Mainly so it doesn't crash in simulator)
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            //Set up the image picker
            ip = UIImagePickerController()
            ip.delegate = self
            ip.allowsEditing = false
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
            ip.allowsEditing = false
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
        
        bannerView.adUnitID = "ca-app-pub-7169101247679253/8212760615"
        bannerView.rootViewController = self
        bannerView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bannerView.load(GADRequest())
    }
    
    
    //This function makes it more convenient to add an alert
    func alert(_ input: String){
        let alert = UIAlertController(title: "Word Capture", message: input, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //When the image is finished picking
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            picker.dismiss(animated: true, completion: nil)
            let cropController = CropViewController(image: image)
            cropController.delegate = self
            present(cropController, animated: true, completion: nil)
        }
    }
    
    //Allow the image to be cropped
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true, completion: nil)
        //Note the callback function
        ImageProcess.imageToText(image: image, callback: addToModel)
        ip.dismiss(animated: true, completion: nil)
    }
    
    //Placeholder callback for debugging
    func printResult(_ input: String, _ image: UIImage){
        print(input)
    }
    
    //Actual callback that is used 
    func addToModel(_ input: String, _ image: UIImage){
        //Add to model
        model.addImage(image: image, text: input)
        
        //Open in storyboard
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let textView = sb.instantiateViewController(withIdentifier: "TextView") as! TextViewController
        textView.text = model.getLastImage()?.text ?? "NA"
        textView.index = max(0, model.getSize() - 1)
        textView.modalPresentationStyle = .fullScreen
        self.present(textView, animated: true, completion: nil)
    }
    


}

