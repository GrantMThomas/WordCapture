//
//  TextViewController.swift
//  ThomasGrantFinalProject
//
//  Created by Grant Thomas on 12/7/19.
//  Copyright © 2019 Grant Thomas. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UITextViewDelegate {
    
    var text:String = "NA"
    var index:Int = 0
    let model = Model.shared
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var stepper: UIStepper!
    
    //Change font size based on value of stepper
    @IBAction func stepperPressed(_ sender: Any) {
        textView.font = UIFont(name: "System Font Regular", size: CGFloat(stepper.value))
    }
    
    
    
    @IBAction func sharePressed(_ sender: Any) {
        let words = [textView.text ?? "NA"]
        let activityViewController = UIActivityViewController(activityItems: words as [String], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTap(_ sender: Any) {
        textView.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = text
        textView.delegate = self
        
        //Set default stepper value
        stepper.value = Double(textView.font?.pointSize ?? 30)
        
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
