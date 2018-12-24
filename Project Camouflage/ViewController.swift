//
//  ViewController.swift
//  Project Camouflage
//
//  Created by Carlos on 12/22/18.
//  Copyright © 2018 Carlos. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController, G8TesseractDelegate {
    
    let tesseract: G8Tesseract = G8Tesseract(language: "eng")!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Running OCR")
        
        tesseract.delegate = self
        tesseract.charWhitelist = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        // Select the image we would like to scan using tesseract
        let imageToCheck = UIImage(named: "welcomePhoto")
        // Runs the text recognition on the image given above
        tesseract.image = imageToCheck!
        tesseract.recognize()
        // Print the text from the given image
        print("The text is \(tesseract.recognizedText!)")
    
    }
    
    
    // Function will cancel image recognition if the switches to another screen or exits out of the app
    // We don't want the OCR trying to recognize objects once user has exited
    func shouldCancelImageRecognition(for tesseract: G8Tesseract) -> Bool {
        return false
    }


}

