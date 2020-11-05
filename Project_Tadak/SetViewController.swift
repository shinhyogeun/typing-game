//
//  SetViewController.swift
//  Project_Tadak
//
//  Created by 신효근 on 2020/11/05.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import Firebase

class SetViewController: UIViewController {
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    @IBAction func nickNameChangeButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func deleteMyIDButtonPressed(_ sender: UIButton) {
        
        let example = ref.child("ranking").child("/").child("/\(Auth.auth().currentUser!.uid)")
        
        example.observeSingleEvent(of: DataEventType.value) { (snapshot,key) in
            print(1)
            let children : NSEnumerator = snapshot.children
            for child in children{
                print(2)
                let childSnapShot = child as? DataSnapshot
                let a = childSnapShot!.children
                print("a",a)
            }
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
    }
    
}
