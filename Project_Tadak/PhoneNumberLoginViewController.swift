//
//  PhoneNumberLoginViewController.swift
//  Project_Tadak
//
//  Created by 신효근 on 2020/10/15.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import Firebase

class PhoneNumberLoginViewController: UIViewController {

    @IBOutlet weak var verificationCode: UITextField!

    var phoneNumber : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
    }

    @IBAction func verificationButtonPressed(_ sender: UIButton) {
        if let text = verificationCode.text {
            Login.tryLogin(verificationCode: text) {(isNewUser) in
                if isNewUser {
                    return self.performSegue(withIdentifier:"goToNickNamePage", sender: self)
                }
                return self.performSegue(withIdentifier:"directToMain", sender: self)
            }
        } else {
            return print("인증번호를 입력하지 않았습니다.")
        }
    }

    @IBAction func reVerifyPhone(_ sender: UIButton) {
        Login.ifSucceseSendingMessage(phoneNumber: phoneNumber!, completion: nil)
    }
    
}
