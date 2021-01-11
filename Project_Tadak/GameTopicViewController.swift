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
        
    @IBOutlet weak var koreaButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var extraButton: UIButton!
    
    @IBOutlet weak var koreaLabel: UILabel!
    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func topicButtonPressed(_ sender: UIButton) -> Void{
        if sender == koreaButton {
            GameList.getGameListAndThen(pressedButtonText: koreaLabel.text!) {
                self.performSegue(withIdentifier: "goToSelectionPage", sender: nil)
            }
            return
        }
        
        if sender == englishButton {
            GameList.getGameListAndThen(pressedButtonText: englishLabel.text!) {
                self.performSegue(withIdentifier: "goToSelectionPage", sender: nil)
            }
            return
        }
        
        if sender == extraButton{
            GameList.getGameListAndThen(pressedButtonText: extraLabel.text!) {
                self.performSegue(withIdentifier: "goToSelectionPage", sender: nil)
            }
        }
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        Logout.tryLogout()
    }
}
