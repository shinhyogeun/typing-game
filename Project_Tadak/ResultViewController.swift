//
//  ResultViewController.swift
//  Project_Tadak
//
//  Created by Min_MacBook Pro on 2020/05/21.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var Label_title: UILabel!
    @IBOutlet weak var Label_secondResult: UILabel!
    
    var recode: Double = GameContents.time
    var gameTitle: String = GameContents.name
    var gameInt: Int = 1
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        Label_title.text = gameTitle
        if recode == -1 {
            Label_secondResult.text = "시간초과!"
        } else{
            Label_secondResult.text = String(format: "%.2f", recode)
        }
        GameContents.reset()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "reGame"{
            let secondVC = segue.destination as! MainViewController
//            secondVC.gameData = MyVariables.completeGameArray
            secondVC.gameTitle.text = MyVariables.gameName
        }
        
        if segue.identifier == "goToRankingPage"{
            let secondVC = segue.destination as! RankingViewController
            
        }
        
    }

    @IBAction func restartButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "reGame", sender: nil)
    }
    
    @IBAction func rankingButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRankingPage", sender: nil)
    }
}
