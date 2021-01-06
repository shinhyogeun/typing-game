//
//  AuthViewController.swift
//  Project_Tadak
//
//  Created by 신효근 on 2020/10/13.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {

    @IBOutlet weak var phoneNumber : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        
    }

    @IBAction func verifyPhoneNumber(sender: UIButton) {
        Login.ifSucceseSendingMessage(phoneNumber: phoneNumber.text!) {
            self.performSegue(withIdentifier: "goToCheckingPage", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCheckingPage"{
            (segue.destination as! PhoneNumberLoginViewController).phoneNumber = phoneNumber.text
        }
    }

}
