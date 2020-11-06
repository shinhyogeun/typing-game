//
//  GameTopicViewController.swift
//  Project_Tadak
//
//  Created by 신효근 on 2020/10/31.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import Firebase

class GameTopicViewController: UIViewController {
    // 원형상태바
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    var ref:DatabaseReference!
        
    @IBOutlet weak var koreaButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var extraButton: UIButton!
    
    @IBOutlet weak var koreaLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    
    var nameArr : [String] = ["한글대전","영어대전","Extra"]
    var gameNameArr : [String] = []
    var whatButtonYouChoose = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        navigationController?.isNavigationBarHidden = true
        self.view.addSubview(self.activityIndicator)
                self.koreaLabel.text = self.nameArr[0]
                self.englishLabel.text = self.nameArr[1]
                self.extraLabel.text = self.nameArr[2]
                self.activityIndicator.stopAnimating()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func topicButtonPressed(_ sender: UIButton) {
        var postRef : DatabaseQuery! = ref
        if sender == koreaButton {
            postRef = ref.child("gametitle").child("한글대전")
            whatButtonYouChoose = self.nameArr[0]
            MyVariables.gameTopic = self.nameArr[0]
        } else if sender == englishButton {
            postRef = ref.child("gametitle").child("영어대전")
            whatButtonYouChoose = self.nameArr[1]
            MyVariables.gameTopic = self.nameArr[1]
        } else if sender == extraButton {
            postRef = ref.child("gametitle").child("Extra")
            whatButtonYouChoose = self.nameArr[2]
            MyVariables.gameTopic = self.nameArr[2]
        }
        
        postRef.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
            let children : NSEnumerator = snapshot.children
            for (child) in children {
                let childSnapShot = child as? DataSnapshot
                if let data = (childSnapShot?.value as? String){
                    self.gameNameArr.append(data)
                }
            }
            DispatchQueue.main.async {
                MyVariables.completeArray = self.gameNameArr
                self.performSegue(withIdentifier: "goToSelectionPage", sender: nil)
            }
        }
        
    }
//maintitle을 바꾸는 역할
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSelectionPage" {
            let secondVC = segue.destination as! SelectionViewController
            secondVC.mainTitleString = whatButtonYouChoose
        }
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("로그아웃을 할 수 없습니다.", signOutError)
        }
    }
}
