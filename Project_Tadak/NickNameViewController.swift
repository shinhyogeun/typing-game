//
//  NickNameViewController.swift
//  Project_Tadak
//
//  Created by 신효근 on 2020/10/15.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import Firebase

class NickNameViewController: UIViewController {
    @IBOutlet weak var nickNameLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
    }
    
    @IBAction func nickNameButtonPressed(_ sender: UIButton) {
        if let inputNickName = nickNameLabel.text {
            Login.ifInputNickNameUnique(nick: inputNickName) {
                self.performSegue(withIdentifier: "goToMainPage", sender: nil)
            }
        }
    }
    
}
