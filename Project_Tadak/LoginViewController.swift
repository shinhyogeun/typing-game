//
//  ViewController.swift
//  Project_Tadak
//
//  Created by Min_MacBook Pro on 2020/05/21.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{

    @IBOutlet var TextFieldId: UITextField!
    @IBOutlet var TextFieldPassword: UITextField!
    @IBOutlet var ButtonLogin: UIButton!
    @IBOutlet weak var Labeltest: UILabel!
    
    var inputId: String = ""
    var inputPw: String = ""
    
    let BLUE = UIColor(named: "ColorBlue")
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
    
        
        
        TextFieldId.attributedPlaceholder = NSAttributedString(string: "ID", attributes: [NSAttributedString.Key.foregroundColor: BLUE])

        TextFieldPassword.attributedPlaceholder = NSAttributedString(string: "PW", attributes: [NSAttributedString.Key.foregroundColor: BLUE])
        
        TextFieldId.layer.shadowColor = BLUE?.cgColor
        TextFieldId.layer.shadowRadius = 2
        TextFieldId.layer.shadowOffset = CGSize(width: 0, height: 0)
        TextFieldId.layer.shadowOpacity = 1
        
        TextFieldPassword.layer.shadowColor = BLUE?.cgColor
        TextFieldPassword.layer.shadowRadius = 2
        TextFieldPassword.layer.shadowOffset = CGSize(width: 0, height: 0)
        TextFieldPassword.layer.shadowOpacity = 1
        
        ButtonLogin.layer.cornerRadius = 4
        ButtonLogin.layer.shadowColor = BLUE?.cgColor
        ButtonLogin.layer.shadowRadius = 4
        ButtonLogin.layer.shadowOffset = CGSize(width: 0, height: 0)
        ButtonLogin.layer.shadowOpacity = 1
        
        Labeltest.layer.shadowColor = BLUE?.cgColor
        Labeltest.layer.shadowRadius = 4
        Labeltest.layer.shadowOffset = CGSize(width: 0, height: 0)
        Labeltest.layer.shadowOpacity = 1
        
        
        
        self.hideKeyboard()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.isNavigationBarHidden = true
       }

}

