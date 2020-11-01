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
    var nameArr : [String] = []
    @IBOutlet weak var gameTableView: UITableView!
    
    override func viewDidLoad() {
        gameTableView.delegate = self
        gameTableView.dataSource = self
        self.gameTableView.register(UINib(nibName: "gameTableViewCell", bundle: nil), forCellReuseIdentifier: "gameCell")
        gameTableView.rowHeight = 100
        ref = Database.database().reference()
        navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
}


extension SelectionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyVariables.completeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.gameTableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! gameTableViewCell
        return cell
    }
    
        
}
