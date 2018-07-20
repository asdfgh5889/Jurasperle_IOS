//
//  KeyboardManagedViewController.swift
//  Abad
//
//  Created by Sherzod on 1/23/18.
//  Copyright © 2018 Sherzod. All rights reserved.
//

import UIKit

@IBDesignable
class KMUITextField: UITextField
{
    var validator: ((String?)->String?)?
    var isValid: Bool?
    var textViewEmbended = false
    
    @IBInspectable
    var offsetLeft: CGFloat = 0
    @IBInspectable
    var offsetRight: CGFloat = 0
    @IBInspectable
    var offsetTop: CGFloat = 0
    @IBInspectable
    var offsetBottom: CGFloat = 0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: offsetTop, left: offsetLeft, bottom: offsetBottom, right: offsetRight);
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: offsetTop, left: offsetLeft, bottom: offsetBottom, right: offsetRight);
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: offsetTop, left: offsetLeft, bottom: offsetBottom, right: offsetRight);
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}

class KeyboardManagedViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet var mainTopContraint: NSLayoutConstraint!
    var textFields = [KMUITextField]()
    var errorColor: UIColor = .red
    var validColor: UIColor = .lightGray
    var allValid: Bool?
    var onReturn: (() -> Void)?
    
    private var hasValidation: Bool = false
    private var initialTop: CGFloat!
    private var keyboardHidded = false
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        if initialTop != nil
        {
            mainTopContraint.constant = initialTop
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize()
    {
        let touch = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(touch)
        for tf in textFields
        {
            tf.delegate = self
            if tf.validator != nil
            {
                self.hasValidation = true
            }
        }
        
        initialTop = mainTopContraint.constant
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resetLayout), name: .UIKeyboardDidHide, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let textField = textField as? KMUITextField
        {
            if let validator = textField.validator
            {
                if let _ = validator(textField.text)
                {
                    textField.borderColor = validColor
                    textField.resignFirstResponder()
                    textField.isValid = true
                    allValid = true
                    for tf in self.textFields
                    {
                        if tf.isValid != nil
                        {
                            if !(tf.isValid!)
                            {
                                allValid = false
                            }
                        }
                    }
                    
                    if let current = self.textFields.index(of: textField)
                    {
                        if self.textFields.count != current + 1
                        {
                            self.textFields[current + 1].becomeFirstResponder()
                        }
                        else
                        {
                            if allValid == nil && hasValidation
                            {
                                textField.becomeFirstResponder()
                                return false
                            }
                            else if allValid != nil && !(allValid!)
                            {
                                textField.becomeFirstResponder()
                                return false
                            }
                            mainTopContraint.constant = initialTop
                            if onReturn != nil
                            {
                                onReturn!()
                            }
                        }
                    }
                }
                else
                {
                    textField.borderColor = errorColor
                    textField.isValid = false
                    allValid = false
                    return false
                }
            }
            else
            {
                textField.borderColor = validColor
                textField.resignFirstResponder()
                
                if let current = self.textFields.index(of: textField)
                {
                    if self.textFields.count != current + 1
                    {
                        self.textFields[current + 1].becomeFirstResponder()
                    }
                    else
                    {
                        if allValid == nil && hasValidation
                        {
                            textField.becomeFirstResponder()
                            return false
                        }
                        else if allValid != nil && !(allValid!)
                        {
                            textField.becomeFirstResponder()
                            return false
                        }
                        mainTopContraint.constant = initialTop
                        if onReturn != nil
                        {
                            onReturn!()
                        }
                    }
                }
            }
        }
        
        return true
    }
    
    @objc private func resetLayout()
    {
        if keyboardHidded
        {
            mainTopContraint.constant = initialTop
        }
    }
    
    @objc private func keyboardShow(_ notification: NSNotification)
    {
        if self.viewIfLoaded?.window != nil
        {
            let keyboardFrame = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect
            let y1 = self.view.frame.height - keyboardFrame.height
            var y2: CGFloat = 0
            
            for tf in self.textFields
            {
                if tf.isFirstResponder
                {
                    //y1 = self.view.convert(keyboardFrame.origin, to: self.view).y
                    if tf.textViewEmbended
                    {
                        y2 = tf.convert(tf.frame.origin, to: self.view).y
                    }
                    else
                    {
                        y2 = tf.frame.origin.y
                    }
                    break
                }
            }
            
            //print("\(y1) -- \(y2)")
            if y2 >= y1 - 50
            {
                mainTopContraint.constant = mainTopContraint.constant + (y1 - y2 - 40)
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    @objc private func dismissKeyboard()
    {
        for tf in self.textFields
        {
            if tf.isFirstResponder
            {
                tf.resignFirstResponder()
                mainTopContraint.constant = initialTop
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
                break
            }
        }
    }
    
}
