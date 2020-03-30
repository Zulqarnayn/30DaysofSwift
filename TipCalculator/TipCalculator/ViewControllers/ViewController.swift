//
//  ViewController.swift
//  TipCalculator
//
//  Created by Asif Mujtaba on 3/29/20.
//  Copyright © 2020 Asif Mujtaba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtFieldAmount: UITextField!
    @IBOutlet weak var btnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sliderTip: UISlider!
    
    @IBOutlet weak var lblTipPercentage: UILabel!
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    func initialize() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        adjustKeyboardFrame(keyboardHeight: -64)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keybaordHeight = keyboardRect.height
            adjustKeyboardFrame(keyboardHeight: keybaordHeight)
        }
    }
    
    func adjustKeyboardFrame(keyboardHeight: CGFloat) {
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.btnBottomConstraint.constant = keyboardHeight
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        lblTipPercentage.text = "Tip(\(Int(sender.value))%)"
        
        let percent: Int = Int(sender.value)
        let tip = calculateTipsAndUpdate(tipPer: percent)
        
        updateTipLabelWith(tip: tip)
    }
    
    func updateTipLabelWith(tip: Float) {
        lblTip.text = String(format: "%.2f", tip)
        let amount = Float(txtFieldAmount.text ?? "0") ?? 0
        let total = amount + tip
        lblTotal.text = String(format: "%.2f", total)
    }
    
    func calculateTipsAndUpdate(tipPer: Int) -> Float{
        let amount: Float = Float(txtFieldAmount.text ?? "0") ?? 0
        let floatPercent = Float(tipPer)
        let totalTip = (amount * floatPercent) / 100.0
        return totalTip
    }
    
    
    
    @IBAction func btnDoneAction(_ sender: UIButton) {
         adjustKeyboardFrame(keyboardHeight: -64)
        txtFieldAmount.resignFirstResponder()
    }
    
}
