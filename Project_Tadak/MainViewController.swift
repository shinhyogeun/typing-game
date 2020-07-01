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
    //이전문장, 다음문장 추가 : M
    @IBOutlet var afterLabel: UILabel!
    @IBOutlet var beforeLabel: UILabel!
    //모서리 라운드 위한 View들 : M
    @IBOutlet var timeView: UIView!
    @IBOutlet var labelsView: UIView!
    var WrongCount = 0
    
    
    let jamoArray : Array<String> = []
    var a = 0
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
    var completeTrigger2 = 1
    var ab = 0
    var miss = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        //View들 라운드 : M
        timeView.layer.cornerRadius = 14
        labelsView.layer.cornerRadius = 14
        //시작전에 무엇을 쓸지 보여준다.
        beforeLabel.text = Text.init().textArray[0]
        //timeLabel.text = String(second)
        //input에 입력이 될시에 textFieldDidChange메소드 실행
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    //input에 입력될 시 실행
    @objc func textFieldDidChange(textField: UITextField){
        if let input = textField.text{
            //첫 실행시 타이머 작동 메소드
            if timeTrigger { checkTimeTrigger() }
            //게임종료 조건 전까지 계속 실행
            if endStatus {
                //문장 설정
                if a == 0{
                    afterLabel.text = ""
                    viewLabel.text = Text.init().textArray[a]
                    beforeLabel.text = Text.init().textArray[a+1]
                }
                //비교를 위한 자모음 분해한 배열
                let jamoYouHaveToWrite = Jamo.getJamo(viewLabel.text!)
                let jamoYouAlreadyWrite = Jamo.getJamo(input)
                
                //비교를 위한 글자 분해한 배열
                let whatYouHaveToWrite = Text.init().textArray[a]
                let whatYouAlreadyWrite = input
                
                let attr = NSMutableAttributedString(string: viewLabel.text!)
                
//              여기 부분은 글자의 색을 바꾸고 자연스러운 글자흐름를 위한 부분
                for i in 0...Array(whatYouHaveToWrite).count-1{
                    completeTrigger = Array(whatYouAlreadyWrite).count
                    if i <= Array(whatYouAlreadyWrite).count-1{
                        if Array(String(whatYouAlreadyWrite))[i] == Array(whatYouHaveToWrite)[i] {
                            attr.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location:i,length:1))
                            if i + 1 == completeTrigger{
                                textField.text?.append("*")
                                textField.text = textField.text?.trimmingCharacters(in: ["*"])
                            }
                        }
                        
                        if i>0 {
                            if Array(String(whatYouAlreadyWrite))[i-1] != Array(whatYouHaveToWrite)[i-1]{
                                attr.addAttribute(.foregroundColor, value: UIColor.systemRed, range: NSRange(location:i-1,length:1))
                            }
                        }
                    } else{ break }
                }
                
                //한글자 틀렸는지 인식하는 것
                viewLabel.attributedText = attr
                
                
//              오타개수 계산하기(실시간)
            for i in 0...Array(whatYouHaveToWrite).count-1{
                if i <= Array(whatYouAlreadyWrite).count-1{
                    print(completeTrigger2)
                    if Array(whatYouAlreadyWrite).count > completeTrigger2 {
                        completeTrigger2 = Array(whatYouAlreadyWrite).count
                        print(completeTrigger2)
                        for a in 0..<Array(Jamo.getJamo(String(Array(whatYouHaveToWrite)[completeTrigger2-1]))).count{
                            if Array(Jamo.getJamo(String(Array(whatYouHaveToWrite)[completeTrigger2-1])))[a] !=
                                Array(Jamo.getJamo(String(Array(whatYouAlreadyWrite)[completeTrigger2-1])))[a]{
                                miss += 1
                            }
                            
                        }
                    }
                } else {
                    print(miss)
                    ab = 0
                }
            }
                
                //타자를 치고있고 쳤는데 내용이 동일한 경우
                if Array(jamoYouHaveToWrite) == Array(jamoYouAlreadyWrite){
                    a = a + 1
                    completeTrigger = 1
                    showArrays()
                    viewLabel.textColor = .black
                }
                //내용이 틀리지만 글자수가 동일한 경우
                else if Array(viewLabel.text!).count < Array(input).count{
                    a = a + 1
                    completeTrigger = 1
                    showArrays()
                    viewLabel.textColor = .black
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
