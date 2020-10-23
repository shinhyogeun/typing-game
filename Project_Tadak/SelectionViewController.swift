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
        let postRef : DatabaseQuery! = ref.child("game").child("korea").child("애국가")
        postRef.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
            let children : NSEnumerator = snapshot.children
            var forTossArray : Array<String> = []
            for (child) in children {
                let childSnapShot = child as? DataSnapshot
                if let data = (childSnapShot?.value as? String){
                    forTossArray.append(data)
                }
                MyVariables.completeArray = forTossArray
            }
            DispatchQueue.main.async {
                print(MyVariables.completeArray)
                self.performSegue(withIdentifier: "goToGame", sender: nil)
            }
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch let signOutEror as NSError {
            print("로그아웃을 할 수 없습니다.", signOutEror)
        }
    }
}
