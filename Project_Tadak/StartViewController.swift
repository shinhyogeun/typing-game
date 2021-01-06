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

    @IBOutlet weak var Image_logo: UIImageView!
    @IBOutlet weak var Label_1: UILabel!
    @IBOutlet weak var Label_2: UILabel!
    @IBOutlet weak var Button_start: UIButton!
    
    override func viewDidLoad() {
        if Login.isAlreadyIn() {
            return goToMainPage()
        }
        
        animationSetup()
        showLogoToUser()
    }
    
    func animationSetup() -> Void {
        self.Image_logo.transform = CGAffineTransform(translationX: 0, y: 110)
        navigationController?.isNavigationBarHidden = true
        Button_start.layer.cornerRadius = 15
        Label_1.alpha = 0
        Label_2.alpha = 0
        Button_start.alpha = 0
    }
    
    func goToMainPage() -> Void {
        self.performSegue(withIdentifier: "startSegue", sender: nil)
    }
    
    func showLogoToUser() -> Void {
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            self.Image_logo.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 1.3, options: .curveEaseIn, animations: {
            self.Label_1.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 1.8, options: .curveEaseIn, animations: {
            self.Label_2.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 0.7, delay: 3.0, options: .curveEaseIn, animations: {
            self.Button_start.alpha = 1
        }, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
}
