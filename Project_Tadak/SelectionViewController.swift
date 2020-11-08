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
    @IBOutlet weak var mainTitle: UILabel!
    var mainTitleString = ""
    var gameTitleString = ""
    override func viewDidLoad() {
        self.gameTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        gameTableView.delegate = self
        gameTableView.dataSource = self
        self.gameTableView.register(UINib(nibName: "gameTableViewCell", bundle: nil), forCellReuseIdentifier: "gameCell")
        gameTableView.rowHeight = 100
        
        mainTitle.text = mainTitleString
        ref = Database.database().reference()
        navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
    }
}


extension SelectionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyVariables.completeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.gameTableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! gameTableViewCell
        cell.gameLabel.text = MyVariables.completeArray[indexPath.row]
        cell.mainTitleString = mainTitleString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MyVariables.completeGameArray = []
        gameTitleString = MyVariables.completeArray[indexPath.row]
        MyVariables.gameName = MyVariables.completeArray[indexPath.row]
        let postRef : DatabaseQuery! = ref.child("game").child(mainTitleString).child(MyVariables.completeArray[indexPath.row])
        postRef.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
            let children : NSEnumerator = snapshot.children
            for (child) in children {
                let childSnapShot = child as? DataSnapshot
                let childPost : NSString = (childSnapShot?.value as? NSString)!
                MyVariables.completeGameArray.append(childPost as String)
            }
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "goToGamePage", sender: nil)
            }
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGamePage"{
            let secondVC = segue.destination as! MainViewController
            secondVC.gameData = MyVariables.completeGameArray
            secondVC.gameTitle = gameTitleString
        }
    }
}
