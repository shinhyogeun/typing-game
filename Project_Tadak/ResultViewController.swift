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
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        showResult()
    }
    
    func showResult () -> Void {
        Label_title.text = GameContents.name
        
        if GameContents.time == -1 {
            Label_secondResult.text = "시간초과!"
        } else{
            Label_secondResult.text = String(format: "%.2f", GameContents.time)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reGame"{
            GameContents.index = 0
            GameContents.time = 00.00
            let secondVC = segue.destination as! MainViewController
        }
        
        if segue.identifier == "goToRankingPage"{
            let secondVC = segue.destination as! RankingViewController   
        }
        
        if segue.identifier == "select" {
            GameContents.reset()
            let secondVC = segue.destination as! GameTopicViewController
        }
        
    }

    @IBAction func restartButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "reGame", sender: nil)
    }
    
    @IBAction func rankingButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToRankingPage", sender: nil)
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "select", sender: nil)
    }
}
