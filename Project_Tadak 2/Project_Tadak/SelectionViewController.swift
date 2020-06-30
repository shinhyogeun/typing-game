//
//  SelectionViewController.swift
//  Project_Tadak
//
//  Created by Min_MacBook Pro on 2020/05/21.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {

    
    
    @IBOutlet var ViewChoose: UIView!
    @IBOutlet var ButtonEasy: UIButton!
    @IBOutlet var ButtonNomal: UIButton!
    @IBOutlet var ButtonHard: UIButton!
    @IBOutlet var ViewButtons: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ViewChoose.layer.cornerRadius = 10
        ButtonEasy.layer.cornerRadius = 10
        ButtonNomal.layer.cornerRadius = 10
        ButtonHard.layer.cornerRadius = 10
        ViewButtons.layer.cornerRadius = 14
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
