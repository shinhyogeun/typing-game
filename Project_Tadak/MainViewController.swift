//
//  MainViewController.swift
//  Project_Tadak
//
//  Created by Min_MacBook Pro on 2020/05/21.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var upperAfterLabel: UILabel!
    @IBOutlet weak var afterLabel: UILabel!
    @IBOutlet weak var nowLabel: UILabel!
    @IBOutlet weak var beforeLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var ImageBackground: UIImageView!
    @IBOutlet weak var upperView: UIView!

    let LABEL = UIColor(named: "ColorLabel")
    let BLUE = UIColor(named: "ColorBlue")
    let RED = UIColor(named: "ColorRed")
    
    var isThisChangeOccuredFirstTime : Bool = true
    var endStatus : Bool = true
    var timeOver : Bool = false
    var timer : Timer = Timer()
    var second : Double = 00.00
    var calculate : Calculate = Calculate.init()
    var miss : Int = 0
    var beatNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBlurEffect()
        baseUISetUp()
        baseContentsSetUp()
        baseEventSetUp()
    }
    
    func makeBlurEffect() -> Void {
        let blurView = CustomIntensityVisualEffectView(effect: UIBlurEffect(style: .light), intensity: 0.05)
        let underBlurView = CustomIntensityVisualEffectView(effect: UIBlurEffect(style: .light), intensity: 1)
        
        blurView.frame = self.view.bounds
        underBlurView.frame = self.view.bounds
        upperView.addSubview(blurView)
        upperView.sendSubviewToBack(blurView)
        ImageBackground.addSubview(underBlurView)
        ImageBackground.sendSubviewToBack(underBlurView)
    }
    
    func baseUISetUp () -> Void {
        self.hideKeyboard()
        inputTextField.keyboardType = .default
        navigationController?.isNavigationBarHidden = true
        self.beforeLabel.alpha = 1
    }
    
    func baseContentsSetUp () -> Void {
        gameTitle.text = GameContents.name
        beforeLabel.text = GameContents.body[GameContents.index]
        timeLabel.text = String(format: "%.2f",GameContents.time)
    }
    
    func baseEventSetUp() -> Void {
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }

    @objc func textFieldDidChange(textField: UITextField){
        let answer = GameContents.body[GameContents.index]
        
        if let input = textField.text{
            if isThisChangeOccuredFirstTime {
                return startGame()
            }
            changeTextColorAndAddTimeBaseOnMiss(answer, input, textField)
            
            if isItOKIfGoToNextSentence(answer, input) {
                goToNextSentenceAndShowIt()
            }
        }
    }
    
    func changeTextColorAndAddTimeBaseOnMiss(_ answer : String, _ input : String, _ textField : UITextField) -> Void {
        calculate.changeColor(nowLabel, whatYouHaveToWrite: answer, whatYouAlreadyWrite: input, textField: textField)
        miss = calculate.countMiss(input, whatYouHaveToWrite: answer, whatYouAlreadyWrite: input)
        timeLabel.text = String(format: "%.2f",GameContents.addTime(Double(miss)))
    }

    func isItOKIfGoToNextSentence (_ answer: String, _ input : String) -> Bool {
        return Array(answer) == Array(input) || Array(nowLabel.text!).count < Array(input).count
    }
    
    func goToNextSentenceAndShowIt() -> Void {
        calculate.resetMissArr()
        GameContents.updateIndex()
        showUpdatedContents()
    }
    
    //첫 실행시 타이머 작동 메소드
    func startGame() {
        //타이머를 시작한다.
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        isThisChangeOccuredFirstTime = false
        setTextFirst()
        UISetUp()
    }
    
    func UISetUp() {
        self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 48)
        self.nowLabel.alpha = 0.5
        UIView.animate(withDuration: 0.3) {
            self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            self.nowLabel.alpha = 1
        }

        self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 48)
        self.beforeLabel.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.beforeLabel.alpha = 0.3
            self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    @objc func updateCounter() {
        if GameContents.isTimeOver() {
            return endGame()
        }
        
        GameContents.updateTime()
        timeLabel.text = String(format: "%.2f",GameContents.time)
    }
    
    func showUpdatedContents() {
        //화면에 내용을 보이는 코드
        
        if(GameContents.index == 1) {
            setTextSecond()
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.afterLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.afterLabel.alpha = 0.3
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.nowLabel.alpha = 0.2
            UIView.animate(withDuration: 0.3) {
                self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.nowLabel.alpha = 1
            }
            self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.beforeLabel.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.beforeLabel.alpha = 0.3
                self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            inputTextField.text = ""
        } else if GameContents.index >= 2 && GameContents.index <= GameContents.body.count - 2 {
            setTextNomal()
            self.upperAfterLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.upperAfterLabel.alpha = 0.3
            UIView.animate(withDuration: 0.3) {
                self.upperAfterLabel.alpha = 0
                self.upperAfterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.afterLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.afterLabel.alpha = 0.3
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.nowLabel.alpha = 0.2
            UIView.animate(withDuration: 0.3) {
                self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.nowLabel.alpha = 1
            }
            self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.beforeLabel.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.beforeLabel.alpha = 0.3
                self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            inputTextField.text = ""
        } else if GameContents.index == GameContents.body.count - 1 {
            setTextLast()
            self.upperAfterLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.upperAfterLabel.alpha = 0.3
            UIView.animate(withDuration: 0.3) {
                self.upperAfterLabel.alpha = 0
                self.upperAfterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.afterLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.afterLabel.alpha = 0.3
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.nowLabel.alpha = 0.2
            UIView.animate(withDuration: 0.3) {
                self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.nowLabel.alpha = 1
            }

            inputTextField.text = ""
        } else if GameContents.index > GameContents.body.count - 1 {
            setTextEnd()
            endGame()
            self.upperAfterLabel.transform = CGAffineTransform(translationX: 0, y: 50)
            self.upperAfterLabel.alpha = 0.3
            UIView.animate(withDuration: 0.3) {
                self.upperAfterLabel.alpha = 0
                self.upperAfterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 50)
            self.afterLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.afterLabel.alpha = 0.5
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 50)
            nowLabel.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.nowLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.nowLabel.alpha = 1
            }
        }
    }
    
    func endGame() {
        timer.invalidate()
        inputTextField.isHidden = true
        endStatus = false
        
        if(GameContents.isTimeOver()) {
            GameContents.time = -1
        } else {
            Recode.updateRecode()
        }
        
        self.view.endEditing(true)
        performSegue(withIdentifier: "endView", sender: self)
    }
    
    func setTextFirst() {
        nowLabel.text = GameContents.body[GameContents.index]
        beforeLabel.text = GameContents.body[GameContents.index + 1]
    }
    
    func setTextSecond() {
        afterLabel.text = GameContents.body[GameContents.index - 1]
        nowLabel.text = GameContents.body[GameContents.index]
        beforeLabel.text = GameContents.body[GameContents.index + 1]
    }
    
    func setTextNomal() {
        upperAfterLabel.text = GameContents.body[GameContents.index - 2]
        afterLabel.text = GameContents.body[GameContents.index - 1]
        nowLabel.text = GameContents.body[GameContents.index]
        beforeLabel.text = GameContents.body[GameContents.index + 1]
    }
    
    func setTextLast() {
        upperAfterLabel.text = GameContents.body[GameContents.index - 2]
        afterLabel.text = GameContents.body[GameContents.index - 1]
        nowLabel.text = GameContents.body[GameContents.index]
        beforeLabel.text = ""
    }
    
    func setTextEnd() {
        upperAfterLabel.text = GameContents.body[GameContents.index - 2]
        afterLabel.text = GameContents.body[GameContents.index - 1]
        nowLabel.text = "게임이 종료되었습니다."
        beforeLabel.text = ""
    }
    
    // 민상이가 손 봐줘야하는 부분
    func heartBeat() {
        self.timeLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: 0.2, animations: {
            self.timeLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
        self.timeLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseIn, animations: {
            self.timeLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    func checkBeat() {
        if(second < 1)
        {
            if(beatNum == 9)
            {
                heartBeat()
                beatNum = 10
            }
            
        }
        else if(second < 2)
        {
            if(beatNum == 8)
            {
                heartBeat()
                beatNum = 9
            }
            
        }
        else if(second < 3)
        {
            if(beatNum == 7)
            {
                heartBeat()
                beatNum = 8
            }
            
        }
        else if(second < 4)
        {
            if(beatNum == 6)
            {
                heartBeat()
                beatNum = 7
            }
            
        }
        else if(second < 5)
        {
            if(beatNum == 5)
            {
                heartBeat()
                beatNum = 6
            }
            
        }
        else if(second < 6)
        {
            if(beatNum == 4)
            {
                heartBeat()
                beatNum = 5
            }
            
        }
        else if(second < 7)
        {
            if(beatNum == 3)
            {
                heartBeat()
                beatNum = 4
            }
            
        }
        else if(second < 8)
        {
            if(beatNum == 2)
            {
                heartBeat()
                beatNum = 3
            }
            
        }
        else if(second < 9)
        {
            if(beatNum == 1)
            {
                heartBeat()
                beatNum = 2
            }
            
        }
        else if(second < 10)
        {
            if(beatNum == 0)
            {
                timeLabel.textColor = UIColor.red
                heartBeat()
                beatNum = 1
            }
        }
    }
}

