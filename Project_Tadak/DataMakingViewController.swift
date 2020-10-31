//
//  DataMakingViewController.swift
//  Project_Tadak
//
//  Created by 신효근 on 2020/10/22.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import Firebase

class DataMakingViewController: UIViewController {
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    @IBAction func updateButtonPressed(_ sender: UIButton) {
        let whereDataLiving = GameText.Korea().koreaText
        for data in whereDataLiving{
            let title = data.key
            let text = data.value
            let childUpdate = ["/game/korea/\(title)" : text]
            ref.updateChildValues(childUpdate)
        }
    }
    
    @IBAction func titleUpdateButtonPressed(_ sender: UIButton) {
        let whereDataLiving = GameText.gameTitle().gameTitle
        for data in whereDataLiving {
            let title = data.key
            let text = data.value
            let childUpdate = ["/gametitle/\(title)":text]
            ref.updateChildValues(childUpdate)
        }
    }
    
}
