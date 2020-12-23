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
    
    // 인증번호를 다시 받아야 할 때를 위해 AuthViewController에서 가져옴
    var phoneNumber : String?
    var dataBase:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        dataBase = Database.database().reference()
    }
    
    //로그인 실행
    @IBAction func verificationButtonPressed(_ sender: UIButton) {
        if let verificationCode = verificationCode.text {
            guard let verificationID = UserDefaults.standard.string(forKey: Text.VERIFICATION_ID)
            else { return print(AlertText.DONT_HAVE_VERIFICATION_ID) }
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error{
                    print(AlertText.FAIL_LOGIN)
                    print(error.localizedDescription)
                    
                    return
                }
                let uid = ["uid":"\(Auth.auth().currentUser!.uid)"]
                let phoneNumebr = ["PhoneNumber":"\(String(describing: Auth.auth().currentUser!.phoneNumber))"]
                
                let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/uid" : uid,
                                   "/users/\(Auth.auth().currentUser!.uid)/PhoneNumber" : phoneNumebr]
                self.dataBase.updateChildValues(childUpdate) { (error , databaseRef) in
                    if let error = error {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier:"directToMain", sender: self)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier:"goToNickNamePage", sender: self)
                        }
                        
                    }
                    
                }
                
            }
        }else{ return print("인증번호를 입력하지 않았습니다.") }
    }
    
    // 인증번호 다시 받기
    @IBAction func reVerifyPhone(_ sender: UIButton) {
        if let phoneNumber = phoneNumber{
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                if let error = error{
                    print("인증번호를 보낼 수 없습니다.")
                    print(error.localizedDescription)
                    return
                }
                UserDefaults.standard.set(verificationID,forKey: "authVerificationID")
            }
        }
    }
    
}
