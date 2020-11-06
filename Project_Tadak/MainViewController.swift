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
    // 100초이상의 경우 여부 저장
    var timeOver: Bool = false
    
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
        if second > 99.9 {
            timeOver = true
            endGame()
            timeLabel.text = String(0.00)

        }
        else {
            second = second + 0.01
            timeLabel.text = String(format: "%.2f",second)

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
        
        if(!timeOver) {
            firebaseUpload()
        }
        else {
            second = -1
        }
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
        viewLabel.text = gameData[a]
        beforeLabel.text = gameData[a+1]
    }
    
    func setTextSecond()
    {
        afterLabel.text = gameData[a-1]
        viewLabel.text = gameData[a]
        beforeLabel.text = gameData[a+1]
    }
    
    func setTextNomal()
    {
        afterLabel2.text = gameData[a-2]
        afterLabel.text = gameData[a-1]
        viewLabel.text = gameData[a]
        beforeLabel.text = gameData[a+1]
    }
    
    func setTextLast()
    {
        afterLabel2.text = gameData[a-2]
        afterLabel.text = gameData[a-1]
        viewLabel.text = gameData[a]
        beforeLabel.text = ""
    }
    
    func setTextEnd()
    {
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
    
    func firebaseUpload()
    {
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////매번 일어나는 저장 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd HH:mm:ss"
        //
        let whenRecodeIsMade = formatter.string(from: Date())
        let recode = second
        let when = Firebase.ServerValue.timestamp()
        var post : [String : Any] = [:]
        
        var forChange : [NSString] = []
        var childPost : NSDictionary = [:]
        var parentChildPost : [NSDictionary] = []
        //
        guard let key = ref.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(MyVariables.gameTopic).child(MyVariables.gameName).childByAutoId().key else{ return }
                post  = [
                         "TIME" : whenRecodeIsMade,
                         "WHEN" : when,
                         "RECODE" : String(format: "%.2f", recode)
                        ]
        forChange.append(String(format: "%.2f", recode) as NSString)
        parentChildPost.append(post as NSDictionary)
        
        let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/recode/\(MyVariables.gameTopic)/\(MyVariables.gameName)/\(key)" : post]
        ref.updateChildValues(childUpdate)
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////매번 일어나는 저장 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let KINGROOT : DatabaseQuery! = ref.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(MyVariables.gameTopic).child(MyVariables.gameName).child("RECODE")
            
            KINGROOT.observeSingleEvent(of: DataEventType.value) { (snapshot,key) in
                let KING = snapshot.value as? NSDictionary ?? [:]
                if KING != [:] {
                    forChange.append(KING["RECODE"] as! NSString)
                    parentChildPost.append(KING)
                    // 드디어 자신의 모든 기록을 깬 신기록 탄생!!!
                    if forChange[0].integerValue < forChange[1].integerValue {
                        
                        let intValue = forChange[0].integerValue
                        let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/recode/\(MyVariables.gameTopic)/\(MyVariables.gameName)/RECODE" : post,
                                           "/ranking/\(MyVariables.gameTopic)/\(MyVariables.gameName)/\(intValue)/total_\(intValue)/\(Auth.auth().currentUser!.uid)" : post,
                                           "/ranking/\(MyVariables.gameTopic)/\(MyVariables.gameName)/RECODES/\(Auth.auth().currentUser!.uid)" : post]
                        self.ref.updateChildValues(childUpdate)
                        
                        let ROOTFORRANK = self.ref.child("ranking").child(MyVariables.gameTopic).child(MyVariables.gameName).child("\(intValue)").child("sum_\(intValue)")
                        ROOTFORRANK.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                            let value = (snapshot.value as! NSNumber).intValue
                            let reverseUpdate = ["/ranking/\(MyVariables.gameTopic)/\(MyVariables.gameName)/\(intValue)/sum_\(intValue)" : value+1]
                            self.ref.updateChildValues(reverseUpdate) }
                        
                        // 기존의 기록에 대한것들은 없에라!!
                        let intValue2 = forChange[1].integerValue
                        let ROOTFORRANK2 = self.ref.child("ranking").child(MyVariables.gameTopic).child(MyVariables.gameName).child("\(intValue2)")
                        
                        ROOTFORRANK2.child("sum_\(intValue2)").observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                            let value = (snapshot.value as! NSNumber).intValue
                            let reverseUpdate = ["/ranking/\(MyVariables.gameTopic)/\(MyVariables.gameName)/\(intValue2)/sum_\(intValue2)" : value-1]
                            self.ref.updateChildValues(reverseUpdate)
                        }
                        ROOTFORRANK2.child("total_\(intValue2)").child(Auth.auth().currentUser!.uid).removeValue()
                    }
                } else {
                    let intValue = forChange[0].integerValue
                    let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/recode/\(MyVariables.gameTopic)/\(MyVariables.gameName)/RECODE" : post,
                                       "/ranking/\(MyVariables.gameTopic)/\(MyVariables.gameName)/\(intValue)/total_\(intValue)/\(Auth.auth().currentUser!.uid)" : post,
                                       "/ranking/\(MyVariables.gameTopic)/\(MyVariables.gameName)/RECODES/\(Auth.auth().currentUser!.uid)" : post]
                    self.ref.updateChildValues(childUpdate)
                    let ROOTFORRANK = self.ref.child("ranking").child(MyVariables.gameTopic).child(MyVariables.gameName).child("\(intValue)").child("sum_\(intValue)")
                    ROOTFORRANK.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                        let value = (snapshot.value as! NSNumber).intValue
                        let reverseUpdate = ["/ranking/\(MyVariables.gameTopic)/\(MyVariables.gameName)/\(intValue)/sum_\(intValue)" : value+1]
                        self.ref.updateChildValues(reverseUpdate)
                    }
                }
            }
        
        
        
        
        //오래된 데이터(30일 이상이 된 DATA)를 지우자
        let now = (Date().timeIntervalSince1970) * 1000
        let cutOff = now - 30*24*60*60*1000
        let postRefAboutOldData = ref.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(MyVariables.gameTopic).child(MyVariables.gameName).queryOrdered(byChild: "/WHEN").queryEnding(atValue: cutOff)
        
        let removePost = ref.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(MyVariables.gameTopic).child(MyVariables.gameName)
        
        postRefAboutOldData.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
            let children : NSEnumerator = snapshot.children
            for child in children {
                let childSnapShot = child as? DataSnapshot
                removePost.child("\(childSnapShot!.key)").removeValue()
            }
        }
    }

    
}

