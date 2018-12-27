//
//  ViewController.swift
//  Project Camouflage
//
//  Created by Carlos on 12/22/18.
//  Copyright © 2018 Carlos. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController, G8TesseractDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // Language used by tesseract to read images
    let tesseract: G8Tesseract = G8Tesseract(language: "eng")!

    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var photoLibrary: UIButton!
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var displayReadText: UILabel!
    
    
    // CameraButton action opens up camera when user clicks on camera button
    @IBAction func cameraAction(_ sender: UIButton) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated:true, completion: nil)
    }
    
    
    // photoLibraryAction open up our photo library
    @IBAction func photoLibraryAction(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated:true, completion: nil)
    }
    
    
    // Displays the photo we have taken or chose from our photo library in our viewController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        imageDisplay.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        // Pass the photo we attained from Camera or Photo Library to tesseractTextReader() to read
        tesseractTextReader(pic: imageDisplay.image!)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    

    // Function will cancel image recognition if the switches to another
    // screen or exits out of the app
    // We don't want the OCR trying to recognize objects once user has exited
    func shouldCancelImageRecognition(for tesseract: G8Tesseract) -> Bool {
        return false
    }

    
    

    
    // Runs tesseract which allows text from image to be analyze
    // Parameter: pic is
    func tesseractTextReader(pic: UIImage){
        // Tests to make sure we are in the function
        print("Running OCR")
        
        tesseract.delegate = self
        // List of white characters used to decode image
        tesseract.charWhitelist = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        
        // Assigns the image passed to imageToCheck
        let imageToCheck = pic
        // Runs the text recognition on the image
        tesseract.image = imageToCheck
        tesseract.recognize()
        // Print the text from the given image in the debugger(bottom)
        print("The text is \(tesseract.recognizedText!)")
        // Print the text in the UILabel in the app
        displayReadText.text = tesseract.recognizedText!
    }

}

