//
//  Check1ViewController.swift
//  Project_Tadak
//
//  Created by Kang Minsang on 2020/10/14.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit

class Check3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()

        navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func Button_start(_ sender: UIButton) {
        UserDefaults.standard.set(1, forKey: "check")
    }
    
}
