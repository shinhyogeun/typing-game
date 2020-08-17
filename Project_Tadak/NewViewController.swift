//
//  NewViewController.swift
//  Project_Tadak
//
//  Created by Min_MacbookPro on 2020/08/14.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {

    @IBOutlet weak var Text_ID: UITextField!
    @IBOutlet weak var Text_PW: UITextField!
    @IBOutlet weak var Text_NAME: UITextField!
    @IBOutlet weak var Text_PHONE: UITextField!
    @IBOutlet weak var Text_EMAIL: UITextField!
    
    @IBOutlet weak var Button_Make: UIButton!
    
    let BLUE = UIColor(named: "ColorBlue")
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        self.hideKeyboard()
        
        Button_Make.isUserInteractionEnabled = false
        
        Text_ID.keyboardType = .alphabet
        Text_PW.keyboardType = .alphabet
        Text_NAME.keyboardType = .default
        Text_PHONE.keyboardType = .numberPad
        Text_EMAIL.keyboardType = .alphabet
        
        Text_ID.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Text_PW.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Text_NAME.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Text_PHONE.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        Text_EMAIL.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        Text_PHONE.addTarget(self, action: #selector(textFieldDidChange2(textField:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if(check())
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.Button_Make.titleLabel?.textColor = self.BLUE
                self.Button_Make.layer.cornerRadius = 4
                self.Button_Make.layer.shadowColor = self.BLUE?.cgColor
                self.Button_Make.layer.shadowRadius = 4
                self.Button_Make.layer.shadowOffset = CGSize(width: 0, height: 0)
                self.Button_Make.layer.shadowOpacity = 1
            })
            Button_Make.isUserInteractionEnabled = true
        }
        else
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.Button_Make.titleLabel?.textColor = UIColor.white
                self.Button_Make.layer.cornerRadius = 4
                self.Button_Make.layer.shadowColor = UIColor.black.cgColor
                self.Button_Make.layer.shadowRadius = 4
                self.Button_Make.layer.shadowOffset = CGSize(width: 0, height: 0)
                self.Button_Make.layer.shadowOpacity = 1
            })
            Button_Make.isUserInteractionEnabled = false
        }
    }
    
    @objc func textFieldDidChange2(textField: UITextField){
        if(Text_PHONE.text?.count == 3)
        {
            Text_PHONE.text! = Text_PHONE.text! + "-"
        }
        if(Text_PHONE.text?.count == 8)
        {
            Text_PHONE.text! = Text_PHONE.text! + "-"
        }
        if(Text_PHONE.text?.count == 13)
        {
            self.view.endEditing(true)
        }
    }
    

    func check() -> Bool
    {
        if(Text_ID.text == "")
        {
            return false
        }
        if(Text_PW.text == "")
        {
            return false
        }
        if(Text_NAME.text == "")
        {
            return false
        }
        if(Text_PHONE.text == "")
        {
            return false
        }
        if(Text_EMAIL.text == "")
        {
            return false
        }
        return true
    }

}
