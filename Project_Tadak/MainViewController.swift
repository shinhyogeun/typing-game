//
//  MainViewController.swift
//  Project_Tadak
//
//  Created by Min_MacBook Pro on 2020/05/21.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var afterLabel: UILabel!
    @IBOutlet var beforeLabel: UILabel!
    @IBOutlet var timeView: UIView!
    @IBOutlet var labelsView: UIView!
    var WrongCount = 0
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        timeView.layer.cornerRadius = 14
        labelsView.layer.cornerRadius = 14
        beforeLabel.text = Text.init().textArray[0]
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        let calculate = Calculate()
    }
    
    //input에 입력될 시 실행
    @objc func textFieldDidChange(textField: UITextField){
        if let input = textField.text{
            //첫 실행시 타이머 작동 메소드
            if timeTrigger { checkTimeTrigger() }
            //게임종료 조건 전까지 계속 실행
            if endStatus {
                //문장 설정
                if a == 0 {
                    afterLabel.text = ""
                    viewLabel.text = Text.init().textArray[a]
                    beforeLabel.text = Text.init().textArray[a+1]
                }
                //비교를 위한 자모음 분해한 배열
                let whatYouHaveToWrite = Text.init().textArray[a]
                let whatYouAlreadyWrite = input
                
                calculate.countMiss(input, whatYouHaveToWrite: whatYouHaveToWrite, whatYouAlreadyWrite: whatYouAlreadyWrite)
                calculate.changeColor(viewLabel, whatYouHaveToWrite: whatYouHaveToWrite, whatYouAlreadyWrite: whatYouAlreadyWrite, textField: textField)
               
                //타자를 치고있고 쳤는데 내용이 동일한 경우
                if Array(whatYouHaveToWrite) == Array(whatYouAlreadyWrite){
                    a = a + 1
                    completeTrigger = 1
                    showArrays()
                    viewLabel.textColor = .black
                    completeTrigger2 = 0
                }
                //내용이 틀리지만 글자수가 동일한 경우
                else if Array(viewLabel.text!).count < Array(input).count{
                    a = a + 1
                    completeTrigger = 1
                    showArrays()
                    viewLabel.textColor = .black
                    completeTrigger2 = 0
                }
                
            }
            
        }
    }
    
    @objc func updateCounter(){
//        if String(format: "%.2f",second) == "0.00"{
        if second < 0.00 {
            endGame()
            timeLabel.text = String(0.00)
            //시간제한이 끝났을때 일어날 일(세그웨이로 실패한 페이지 혹은 팝업을 띄운다.)
        } else {
            second = second + 0.01
            timeLabel.text = String(format: "%.2f",second)
        }
    }
    
    //첫 실행시 타이머 작동 메소드
    func checkTimeTrigger() {
        realTime = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        numOfArray = Text.init().textArray.count
        timeTrigger = false
    }
    
    func showArrays() {
        //화면에 내용을 보이는 코드
        if a > 0 && a < numOfArray-1
        {
            afterLabel.text = Text.init().textArray[a-1]
            viewLabel.text = Text.init().textArray[a]
            
            self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 75)
            beforeLabel.alpha = 0
            UIView.animate(withDuration: 0.4) {
                self.beforeLabel.alpha = 1;
                self.beforeLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.viewLabel.transform = CGAffineTransform(translationX: 0, y: 75)
//            viewLabel.alpha = 0
            UIView.animate(withDuration: 0.4) {
//                self.viewLabel.alpha = 1;
                self.viewLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 75)
            afterLabel.alpha = 1
            UIView.animate(withDuration: 0.4) {
                self.afterLabel.alpha = 0;
                self.afterLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            beforeLabel.text = Text.init().textArray[a+1]
            inputTextField.text = ""
        }
        else if a == numOfArray-1
        {
            afterLabel.text = Text.init().textArray[a-1]
            viewLabel.text = Text.init().textArray[a]
            beforeLabel.text = ""
            inputTextField.text = ""
        }
        else if a > numOfArray-1
        {
            endGame()
        }
    }
    
    func endGame() {
        realTime.invalidate()
        //종료시 보이는 문장 수정 : M
        afterLabel.text = ""
        viewLabel.text = "게임이 종료되었습니다."
        beforeLabel.text = ""
        inputTextField.isHidden = true
        //종료조건 : M
        endStatus = false
    }

    
}

//extension Array {
//    subscript(safe index: Index) -> Element? {
//        return indices.contains(index) ? self[index] : nil
//    }
//}
