//
//  SelectionViewController.swift
//  Project_Tadak
//
//  Created by Min_MacBook Pro on 2020/05/21.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import Firebase

class SelectionViewController: UIViewController {
    var ref:DatabaseReference!
    var index:Int = 1
    override func viewDidLoad() {
        ref = Database.database().reference()
        navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        
    }
    
//    @IBAction func Button_Test1(_ sender: UIButton) {
//        performSegue(withIdentifier: "test1", sender: self)
//    }
//    
//    @IBAction func Button_Test2(_ sender: UIButton) {
//        performSegue(withIdentifier: "test2", sender: self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "test1"{
            let secondVC = segue.destination as! MainViewController
            secondVC.gameInt = 1
        }
        else if segue.identifier == "test2"{
            let secondVC = segue.destination as! MainViewController
            secondVC.gameInt = 2
        }
        else if segue.identifier == "test3"{
            let secondVC = segue.destination as! MainViewController
            secondVC.gameInt = 3
        }
    }
    @IBAction func TEST1ButtonPressed(_ sender: UIButton) {
        let postRef : DatabaseQuery! = ref.child("users").child(Auth.auth().currentUser!.uid).child("한국어게임")
        postRef.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
            let children : NSEnumerator = snapshot.children
            for (child) in children {
                let childSnapShot = child as? DataSnapshot
//                let a = (childSnapShot?.value as? NSArray)! as! Array<String>
                MyVariables.completeArray = (childSnapShot?.value as? NSArray)! as! Array<String>
                DispatchQueue.main.async {
                    print(MyVariables.completeArray)
                    self.performSegue(withIdentifier: "goToGame", sender: nil)
                }
            }
        }
    }
    
}
