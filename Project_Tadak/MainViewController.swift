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
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var afterLabel2: UILabel!
    @IBOutlet weak var afterLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var beforeLabel: UILabel!
    @IBOutlet weak var Label_title: UILabel!
    
    //blur
    @IBOutlet weak var ImageBackground: UIImageView!
    @IBOutlet weak var upperView: UIView!
    
    var WrongCount = 0
    var calculateBaseArr : Array<Int> = []
    
    let jamoArray : Array<String> = []
    var a = 0
    var aa = 2
    var timeTrigger = true
    var realTime = Timer()
    var second : Double = 00.00
    //종료조건 추가 : M
    var endStatus = true
    //문장 개수 : M
    var numOfArray = 0
    var calculate = Calculate.init()
    var input = ""
    var completeTrigger = 1
    var completeTrigger2 = 0
    var ab = 0
    var miss = 0
    var baseWholeArraycount = 0
    
    let LABEL = UIColor(named: "ColorLabel")
    let BLUE = UIColor(named: "ColorBlue")
    let RED = UIColor(named: "ColorRed")

    //가사선택 테스트
    var gameInt: Int = 1
    var gameTitle: String = ""
    var gameData: Array<String> = []
    
    //심장박동
    var beatNum: Int = 0
    
    //loading 추가
    var isLoad: Bool = false
    // firebase
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //blur
        let blur = UIBlurEffect(style: .light)
        let underBlur = UIBlurEffect(style: .light)
        
        let blurView = CustomIntensityVisualEffectView(effect: blur, intensity: 0.05)
        let underBlurView = CustomIntensityVisualEffectView(effect: underBlur, intensity: 1)
        
        blurView.frame = self.view.bounds
        underBlurView.frame = self.view.bounds
        
        ImageBackground.addSubview(underBlurView)
        ImageBackground.sendSubviewToBack(underBlurView)
        upperView.addSubview(blurView)
        upperView.sendSubviewToBack(blurView)
        Label_title.text = gameTitle
        navigationController?.isNavigationBarHidden = true
        
        self.hideKeyboard()
        
        inputTextField.keyboardType = .default
        timeLabel.text = String(format: "%.2f",second)
        beforeLabel.text = gameData[0]
         
        self.beforeLabel.alpha = 1
//        beforeLabel.textColor = LABEL
        viewLabel.text = ""
        afterLabel.text = ""
        afterLabel2.text = ""
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        ref = Database.database().reference()
        let calculate = Calculate()
    }
    
    //input에 입력될 시 실행
    @objc func textFieldDidChange(textField: UITextField){
        if let input = textField.text{
            Array(input).count + baseWholeArraycount
            //첫 실행시 타이머 작동 메소드
            if timeTrigger { checkTimeTrigger() }
            //게임종료 조건 전까지 계속 실행
            if endStatus {
                
                //비교를 위한 자모음 분해한 배열
//                let whatYouHaveToWrite = Text.init().textArray[a]
                let whatYouHaveToWrite = gameData[a]
                let whatYouAlreadyWrite = input
                
                miss = calculate.countMiss(input, whatYouHaveToWrite: whatYouHaveToWrite, whatYouAlreadyWrite: whatYouAlreadyWrite)
                calculate.changeColor(viewLabel, whatYouHaveToWrite: whatYouHaveToWrite, whatYouAlreadyWrite: whatYouAlreadyWrite, textField: textField)
                
                
                //여기서 미스를 누적해서 시간을 건드려라!!!
                second = second + Double(miss)
                timeLabel.text = String(format: "%.2f",second)
//                calculateBaseArr.append(miss)
//                print(calculateBaseArr)
//                if calculateBaseArr.count >= 2 { print(calculateBaseArr.last! - calculateBaseArr[calculateBaseArr.count-2]) }
                
                //타자를 치고있고 쳤는데 내용이 동일한 경우
                if Array(whatYouHaveToWrite) == Array(whatYouAlreadyWrite){
                    calculate.missArr = []
                    baseWholeArraycount += Array(whatYouAlreadyWrite).count
                    a = a + 1
                    completeTrigger = 1
                    showArrays()
                    viewLabel.textColor = .white
                    completeTrigger2 = 0
                }
                //내용이 틀리지만 글자수가 동일한 경우
                else if Array(viewLabel.text!).count < Array(input).count{
                    calculate.missArr = []
                    baseWholeArraycount += Array(input).count
                    a = a + 1
                    completeTrigger = 1
                    showArrays()
                    viewLabel.textColor = .white
                    completeTrigger2 = 0
                }
                
            }
            
        }
    }
    
    @objc func updateCounter(){
        if second < 0.0 {
            endGame()
            timeLabel.text = String(0.00)
//          calculate.calculateSpeed( timeLabel.text, )
            //시간제한이 끝났을때 일어날 일(세그웨이로 실패한 페이지 혹은 팝업을 띄운다.)
        }
        else {
            second = second + 0.01
            timeLabel.text = String(format: "%.2f",second)
//          calculate.calculateSpeed()
            
            //심장박동 함수
//            checkBeat()
        }
    }
    
    //첫 실행시 타이머 작동 메소드
    func checkTimeTrigger() {
        realTime = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        numOfArray = gameData.count
        timeTrigger = false
        
        setTextFirst()
        
        self.viewLabel.transform = CGAffineTransform(translationX: 0, y: 48)
        self.viewLabel.alpha = 0.5
        UIView.animate(withDuration: 0.3) {
            self.viewLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            self.viewLabel.alpha = 1
        }
        
//        viewLabel.layer.shadowColor = BLUE?.cgColor
//        viewLabel.layer.shadowRadius = 2
//        viewLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
//        viewLabel.layer.shadowOpacity = 0.7

        self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 48)
        self.beforeLabel.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.beforeLabel.alpha = 0.3
            self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    func showArrays() {
        //화면에 내용을 보이는 코드
        if(a == 1)
        {
            setTextSecond()
            
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.afterLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.afterLabel.alpha = 0.3
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.viewLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.viewLabel.alpha = 0.2
            UIView.animate(withDuration: 0.3) {
                self.viewLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.viewLabel.alpha = 1
            }

            self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.beforeLabel.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.beforeLabel.alpha = 0.3
                self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }

            
            inputTextField.text = ""
        }
        else if a >= 2 && a <= numOfArray-2
        {
            setTextNomal()
            
            self.afterLabel2.transform = CGAffineTransform(translationX: 0, y: 48)
            self.afterLabel2.alpha = 0.3
            UIView.animate(withDuration: 0.3) {
                self.afterLabel2.alpha = 0
                self.afterLabel2.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.afterLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.afterLabel.alpha = 0.3
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.viewLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.viewLabel.alpha = 0.2
            UIView.animate(withDuration: 0.3) {
                self.viewLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.viewLabel.alpha = 1
            }

            self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.beforeLabel.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.beforeLabel.alpha = 0.3
                self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            inputTextField.text = ""
            
            
        }
        
        else if a == numOfArray-1
        {
            setTextLast()
            
            self.afterLabel2.transform = CGAffineTransform(translationX: 0, y: 48)
            self.afterLabel2.alpha = 0.3
            UIView.animate(withDuration: 0.3) {
                self.afterLabel2.alpha = 0
                self.afterLabel2.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.afterLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.afterLabel.alpha = 0.3
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.viewLabel.transform = CGAffineTransform(translationX: 0, y: 48)
            self.viewLabel.alpha = 0.2
            UIView.animate(withDuration: 0.3) {
                self.viewLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.viewLabel.alpha = 1
            }
            
            
            inputTextField.text = ""
        }
        else if a > numOfArray-1
        {
            setTextEnd()
            endGame()
            
            self.afterLabel2.transform = CGAffineTransform(translationX: 0, y: 50)
            self.afterLabel2.alpha = 0.3
            UIView.animate(withDuration: 0.3) {
                self.afterLabel2.alpha = 0
                self.afterLabel2.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 50)
            self.afterLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.afterLabel.alpha = 0.5
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.viewLabel.transform = CGAffineTransform(translationX: 0, y: 50)
            viewLabel.alpha = 0
            UIView.animate(withDuration: 0.3) {
                self.viewLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.viewLabel.alpha = 1
            }
        }
    }
    
    func endGame() {
        realTime.invalidate()
        //종료시 보이는 문장 수정 : M
        
        inputTextField.isHidden = true
        //종료조건 : M
        endStatus = false
        
        // 기록을 넣자 개인기록
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd HH:mm:ss"
        let whenRecodeIsMade = formatter.string(from: Date())
        let recode = second
        guard let key = ref.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(MyVariables.gameTopic).child(MyVariables.gameName).childByAutoId().key else{ return }
        let post = ["TIME" : whenRecodeIsMade,
                    "RECODE" : String(format: "%.3f", recode)]
        let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/recode/\(MyVariables.gameTopic)/\(MyVariables.gameName)/\(key)" : post]
        ref.updateChildValues(childUpdate)
        
        self.view.endEditing(true)
        performSegue(withIdentifier: "endView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "endView"{
            
            let secondVC = segue.destination as! ResultViewController
            secondVC.data = second
            secondVC.gameTitle = gameTitle
            secondVC.gameInt = gameInt
        }
    }
    
    func setTextFirst()
    {
//        viewLabel.text = Text.init().textArray[a]
//        beforeLabel.text = Text.init().textArray[a+1]
        viewLabel.text = gameData[a]
        beforeLabel.text = gameData[a+1]
    }
    
    func setTextSecond()
    {
//        afterLabel.text = Text.init().textArray[a-1]
//        viewLabel.text = Text.init().textArray[a]
//        beforeLabel.text = Text.init().textArray[a+1]
        afterLabel.text = gameData[a-1]
        viewLabel.text = gameData[a]
        beforeLabel.text = gameData[a+1]
    }
    
    func setTextNomal()
    {
//        afterLabel2.text = Text.init().textArray[a-2]
//        afterLabel.text = Text.init().textArray[a-1]
//        viewLabel.text = Text.init().textArray[a]
//        beforeLabel.text = Text.init().textArray[a+1]
        afterLabel2.text = gameData[a-2]
        afterLabel.text = gameData[a-1]
        viewLabel.text = gameData[a]
        beforeLabel.text = gameData[a+1]
    }
    
    func setTextLast()
    {
//        afterLabel2.text = Text.init().textArray[a-2]
//        afterLabel.text = Text.init().textArray[a-1]
//        viewLabel.text = Text.init().textArray[a]
//        beforeLabel.text = ""
        afterLabel2.text = gameData[a-2]
        afterLabel.text = gameData[a-1]
        viewLabel.text = gameData[a]
        beforeLabel.text = ""
    }
    
    func setTextEnd()
    {
//        afterLabel2.text = Text.init().textArray[a-2]
//        afterLabel.text = Text.init().textArray[a-1]
//        viewLabel.text = "게임이 종료되었습니다."
//        beforeLabel.text = ""
        afterLabel2.text = gameData[a-2]
        afterLabel.text = gameData[a-1]
        viewLabel.text = "게임이 종료되었습니다."
        beforeLabel.text = ""
    }
    
    func heartBeat()
    {
        self.timeLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: 0.2, animations: {
            self.timeLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
        self.timeLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseIn, animations: {
            self.timeLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    func checkBeat()
    {
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

