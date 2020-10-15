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
        
    }

    @IBAction func verifyPhoneNumber(sender: UIButton) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber.text!, uiDelegate: nil) { (verificationID, error) in
            if let error = error{
                print("인증번호를 보낼 수 없습니다.")
                print(error.localizedDescription)
                return
            }
            UserDefaults.standard.set(verificationID,forKey: "authVerificationID")
            self.performSegue(withIdentifier: "goToCheckingPage", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToCheckingPage"{
            let destinationVC = segue.destination as! PhoneNumberLoginViewController
            destinationVC.phoneNumber = phoneNumber.text
        }
    }

}
