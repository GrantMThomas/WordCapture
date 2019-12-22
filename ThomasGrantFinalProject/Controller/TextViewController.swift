//
//  TextViewController.swift
//  ThomasGrantFinalProject
//
//  Created by Grant Thomas on 12/7/19.
//  Copyright © 2019 Grant Thomas. All rights reserved.
//  gmthomas@usc.edu

import UIKit

class TextViewController: UIViewController, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var text:String = "NA"
    var index:Int = 0
    
    var picker:UIPickerView!
    var toolbar:UIToolbar!
    var font = "System Font Regular"
    
    let model = Model.shared
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var stepper: UIStepper!
    
    //Change font size based on value of stepper
    @IBAction func stepperPressed(_ sender: Any) {
        //Change font to stepper value
        textView.font = UIFont(name: model.getImageText(at: index)?.fontType ?? "System Font Regular", size: CGFloat(stepper.value))
        
        //Save in model as well
        model.setFontSize(at: index, size: stepper.value)
    }
    
    
    //Activity controller to share, copy, etc.
    @IBAction func sharePressed(_ sender: Any) {
        let words = [textView.text ?? "NA"]
        let activityViewController = UIActivityViewController(activityItems: words as [String], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func fontButtonPressed(_ sender: Any) {
        
        //To hold the picker view and toolbar
        
        picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        //Style the picker
        picker.backgroundColor = view.backgroundColor
        picker.frame = CGRect(x: 0, y: view.frame.height - view.frame.height/2, width: view.frame.width, height: view.frame.height / 2)
        
        
        //Create toolbar
        toolbar = UIToolbar()
        //toolbar.frame = CGRect(x: picker.frame.midX, y: picker.frame.midY, width: picker.frame.width, height: 200)
        toolbar.frame = CGRect(x: picker.frame.minX, y: picker.frame.minY, width: view.frame.width, height: view.frame.height)
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        //Add button to toolbar
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.clickedDone))
        toolbar.setItems([done], animated: false)
        
        //Set default font
        font = UIFont.familyNames[0]
        
                
        view.addSubview(picker)
        view.addSubview(toolbar)

    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //To dismiss keyboard
    @IBAction func didTap(_ sender: Any) {
        textView.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = text
        textView.delegate = self
        
        //Set default stepper value
        stepper.value = model.getImageText(at: index)?.fontSize ?? 20
        let fontType = model.getImageText(at: index)?.fontType ?? "System Font Regular"
        
        //Set font size
        textView.font = UIFont(name: fontType, size: CGFloat(stepper.value))
        
        
    }
    
    //Same function as flashcard homework to return
    func textViewDidChange(_ textView: UITextView) {
        var viewString = textView.text ?? ""
        if viewString.contains("\n") {
            let characterSet = CharacterSet(charactersIn: "\n")
            viewString = viewString.trimmingCharacters(in: characterSet)
            textView.text = viewString
            textView.resignFirstResponder()
        }
        //Update the text
        model.editText(at: index, newText: textView.text)
        
    }
    
    
    // MARK: - Picker View Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UIFont.familyNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return UIFont.familyNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        font = UIFont.familyNames[row]
    }
    
    //To get the correct font
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel{
            label = v
        }
        label.font = UIFont (name: UIFont.familyNames[row], size: 20)
        label.text =  UIFont.familyNames[row]
        label.textAlignment = .center
        return label
        
    }
    
    @objc func clickedDone(){
        picker.removeFromSuperview()
        toolbar.removeFromSuperview()
        
        //Update on UI
        textView.font = UIFont(name: font, size: CGFloat(stepper.value))
        
        //Update in model
        model.setFontType(at: index, font: font)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
