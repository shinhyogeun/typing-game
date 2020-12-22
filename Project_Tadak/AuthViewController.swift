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

    @IBOutlet weak var phoneNumberInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        
    }

    @IBAction func sendNumberButtonPressed(sender: UIButton) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberInput.text!, uiDelegate: nil) { (verificationID, error) in
            if let error = error{
                print(AlertText.CANT_SEND_TEXT_MASSAGE)
                print(error.localizedDescription)
                
                return
            }
            
            self.storeVerificationID(ID: verificationID)
            self.goCheckingPage()
        }
    }
    
    func storeVerificationID(ID : String?) {
        UserDefaults.standard.set(ID,forKey: Text.VERIFICATION_ID)
    }
    
    func goCheckingPage() {
        self.performSegue(withIdentifier: Text.GO_CHECKING_PAGE, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Text.GO_CHECKING_PAGE{
            let destinationVC = segue.destination as! PhoneNumberLoginViewController
            
            destinationVC.phoneNumber = phoneNumberInput.text
        }
    }
    
}
