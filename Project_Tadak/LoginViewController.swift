//
//  ViewController.swift
//  Project_Tadak
//
//  Created by Min_MacBook Pro on 2020/05/21.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
         if let error = error {
           if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
             print("The user has not signed in before or they have since signed out.")
           } else {
             print("\(error.localizedDescription)")
           }
           return
         }
         
        performSegue(withIdentifier: "goToSecondView", sender: self)
        
//         let userId = user.userID
//         let idToken = user.authentication.idToken
//         let fullName = user.profile.name
//         let givenName = user.profile.givenName
//         let familyName = user.profile.familyName
//         let email = user.profile.email
    }
    

    @IBOutlet var TextFieldId: UITextField!
    @IBOutlet var TextFieldPassword: UITextField!
    @IBOutlet var ButtonLogin: UIButton!
    @IBOutlet weak var Labeltest: UILabel!
    @IBOutlet weak var googleButton: GIDSignInButton!
    
    var inputId: String = ""
    var inputPw: String = ""
    
    let BLUE = UIColor(named: "ColorBlue")
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
    GIDSignIn.sharedInstance().clientID = "633673620136-4jbqdkrnbdlu4pc9ncgf3es05987h33q.apps.googleusercontent.com"
    GIDSignIn.sharedInstance().delegate = self
    GIDSignIn.sharedInstance()?.presentingViewController = self
        
        
        TextFieldId.attributedPlaceholder = NSAttributedString(string: "ID", attributes: [NSAttributedString.Key.foregroundColor: BLUE])

        TextFieldPassword.attributedPlaceholder = NSAttributedString(string: "PW", attributes: [NSAttributedString.Key.foregroundColor: BLUE])
        
        TextFieldId.layer.shadowColor = BLUE?.cgColor
        TextFieldId.layer.shadowRadius = 2
        TextFieldId.layer.shadowOffset = CGSize(width: 0, height: 0)
        TextFieldId.layer.shadowOpacity = 1
        
        TextFieldPassword.layer.shadowColor = BLUE?.cgColor
        TextFieldPassword.layer.shadowRadius = 2
        TextFieldPassword.layer.shadowOffset = CGSize(width: 0, height: 0)
        TextFieldPassword.layer.shadowOpacity = 1
        
        ButtonLogin.layer.cornerRadius = 4
        ButtonLogin.layer.shadowColor = BLUE?.cgColor
        ButtonLogin.layer.shadowRadius = 4
        ButtonLogin.layer.shadowOffset = CGSize(width: 0, height: 0)
        ButtonLogin.layer.shadowOpacity = 1
        
        googleButton.layer.cornerRadius = 4
        googleButton.layer.shadowColor = BLUE?.cgColor
        googleButton.layer.shadowRadius = 4
        googleButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        googleButton.layer.shadowOpacity = 1
        
        Labeltest.layer.shadowColor = BLUE?.cgColor
        Labeltest.layer.shadowRadius = 4
        Labeltest.layer.shadowOffset = CGSize(width: 0, height: 0)
        Labeltest.layer.shadowOpacity = 1
        
        
        
        self.hideKeyboard()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func googleButtonPressed(_ sender: Any) {
    GIDSignIn.sharedInstance()?.signIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           navigationController?.isNavigationBarHidden = true
       }

}

