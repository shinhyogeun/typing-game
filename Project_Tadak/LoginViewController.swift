//
//  ViewController.swift
//  Project_Tadak
//
//  Created by Min_MacBook Pro on 2020/05/21.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var TextFieldId: UITextField!
    @IBOutlet var TextFieldPassword: UITextField!
    @IBOutlet var ViewId: UIView!
    @IBOutlet var ViewPassword: UIView!
    @IBOutlet var ButtonLogin: UIButton!
    
    
    let TEXT = UIColor(named: "ColorText")
    
    override func viewDidLoad() {
        TextFieldId.layer.cornerRadius = 14
        
        TextFieldPassword.layer.cornerRadius = 14
        ViewId.layer.cornerRadius = 14
        
        ViewPassword.layer.cornerRadius = 14
        
        TextFieldId.attributedPlaceholder = NSAttributedString(string: "아이디", attributes: [NSAttributedString.Key.foregroundColor: TEXT?.cgColor])
        
        TextFieldPassword.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: TEXT?.cgColor])
        
        ButtonLogin.layer.cornerRadius = 14
        
        self.hideKeyboard()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
