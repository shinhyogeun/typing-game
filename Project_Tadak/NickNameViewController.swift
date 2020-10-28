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
    var ref : DatabaseReference!
    @IBOutlet weak var nickNameLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    
    @IBAction func nickNameButtonPressed(_ sender: UIButton) {
        // 닉네임이 있는지 확인해야한다.
        if let nick = nickNameLabel.text {
            
            let nickname = ["nickname":"\(nick)"]
            let nickname2 = ["nickname":"\(nick)"]
            
            let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/nickname" : nickname]
            let childUpdate2 = ["/nickname/\(nick)" : nickname2]
            self.ref.updateChildValues(childUpdate) { (error, dataSnapshot) in
                if let error = error{
                    print(error.localizedDescription , "이미 다른 사람이 쓰고 있는 것 같습니다.")
                } else{
                    self.ref.updateChildValues(childUpdate2)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier:"goToMainPage", sender: self)
                    }
                }
            }
            
        }
    }
    
}
