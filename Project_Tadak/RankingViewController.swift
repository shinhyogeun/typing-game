//
//  RankingViewController.swift
//  Project_Tadak
//
//  Created by 신효근 on 2020/11/03.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import Firebase

class RankingViewController: UIViewController {
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var rankingLabel: UILabel!
    
    var score : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        let RAKINGROOT = DatabaseReference().child("ranking").child(MyVariables.gameTopic).child(MyVariables.gameName)
        nickNameLabel.text = MyVariables.NICKNAME + "님"
        let whereUare = Int(score)
        var rank = 0
        
        for i in 1...whereUare-1
            {
                RAKINGROOT.child("\(i)").child("sum_\(i)").observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                    rank += (snapshot.value as! NSNumber).intValue
                    }
                print("where",rank)
            }
        
    }
}
