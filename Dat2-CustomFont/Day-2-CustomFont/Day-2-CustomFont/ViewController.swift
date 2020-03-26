//
//  ViewController.swift
//  Day-2-CustomFont
//
//  Created by Asif Mujtaba on 3/26/20.
//  Copyright © 2020 Asif Mujtaba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let fontArray = [ "Raffina", "Lobster-Regular", "Montserrat-Bold", "daddysgirl"]
    @IBOutlet var txtField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnFontAction(_ sender: UIButton) {
        let index = (Int.random(in: 0..<50) + Int.random(in: 0..<4)) % 4
        let font = fontArray[index]
        txtField.font = UIFont(name: font, size: 20.0)
        view.layoutIfNeeded()
    }
    
}

