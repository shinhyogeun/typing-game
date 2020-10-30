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
    
    //이 버튼은 Firebase연동을 통한 문자인증을 위해 임시로 만든 버튼입니다.
    //완료되면 위의 Button_start로 대체하여 연결 할 것입니다.
    @IBOutlet weak var authButton: UIButton!
    
    private func handlePhoneVerificationLogin(){
        authButton.addTarget(self, action: #selector(self.loginPhoneNumber(authButton:)), for: UIControl.Event.touchUpInside)
    }
    
    override func viewDidLoad() {
        
        self.Image_logo.transform = CGAffineTransform(translationX: 0, y: 110)
        navigationController?.isNavigationBarHidden = true

        Button_start.layer.cornerRadius = 15
        
        //alpha
        Label_1.alpha = 0
        Label_2.alpha = 0
        Button_start.alpha = 0
        
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "startSegue", sender: nil)
        }else{
            startAnimation()
        }
        // 화면이 켜지면 바로 밑의 함수를 실행해 로그인 준비를 합니다.
        handlePhoneVerificationLogin()
    }
    
    func startAnimation()
    {
        //animation
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
    
    
    @IBAction func loginPhoneNumber(authButton: UIButton) {
        self.performSegue(withIdentifier: "goToAuthPage", sender: nil)
    }
    
}
