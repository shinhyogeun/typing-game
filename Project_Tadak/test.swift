//
//  test.swift
//  Project_Tadak
//
//  Created by Kang Minsang on 2020/09/23.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit

class test: UIViewController {

    @IBOutlet weak var View_fraim: UIView!
    @IBOutlet weak var Button_login: UIButton!
    @IBOutlet weak var Button_new: UIButton!
    @IBOutlet weak var Text_id: UITextField!
    @IBOutlet weak var Text_pw: UITextField!
    
    let SHADOW = UIColor(named: "ColorShadow")
    override func viewDidLoad() {
        hideKeyboard()
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        View_fraim.layer.cornerRadius = 40
        View_fraim.layer.shadowColor = SHADOW?.cgColor
        View_fraim.layer.shadowRadius = 5
        View_fraim.layer.shadowOffset = CGSize(width: 1, height: 1)
        View_fraim.layer.shadowOpacity = 1
        
        Button_login.layer.cornerRadius = 15
        Button_new.layer.cornerRadius = 15
        
        Text_id.attributedPlaceholder = NSAttributedString(string: "ID", attributes: [NSAttributedString.Key.foregroundColor: SHADOW])
        Text_pw.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: SHADOW])
        
    }
    

}

