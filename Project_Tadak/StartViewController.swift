//
//  StartViewController.swift
//  Project_Tadak
//
//  Created by Kang Minsang on 2020/09/24.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import Firebase

class StartViewController: UIViewController {
    
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        
        if Auth.auth().currentUser != nil {
            return self.performSegue(withIdentifier: "startSegue", sender: nil)
        }
        
        baseSetup()
        fadeInAnimation()
        tryLoginWhenStartButtonPressed()
    }
    
    func baseSetup(){
        startButton.alpha = 0
        mainTitle.alpha = 0
        subTitle.alpha = 0
        startButton.alpha = 0
        startButton.layer.cornerRadius = 15
        self.imageLogo.transform = CGAffineTransform(translationX: 0, y: 110)
        navigationController?.isNavigationBarHidden = true
    }
    
    func fadeInAnimation(){
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            self.imageLogo.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 1.3, options: .curveEaseIn, animations: {
            self.mainTitle.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 1.8, options: .curveEaseIn, animations: {
            self.subTitle.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 3.0, options: .curveEaseIn, animations: {
            self.startButton.alpha = 1
        }, completion: nil)
    }
    
    private func tryLoginWhenStartButtonPressed(){
        startButton.addTarget(self, action: #selector(self.goPhoneNumberInputPage(authButton:)), for: UIControl.Event.touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    @IBAction func goPhoneNumberInputPage(authButton: UIButton) {
        self.performSegue(withIdentifier: "check1", sender: nil)
    }
    
}
