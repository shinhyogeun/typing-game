//
//  Calculate.swift
//  Project_Tadak
//
//  Created by 신효근 on 2020/05/30.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import Foundation
import UIKit

class Calculate {
    
    var aa = 2
    let GREEN = UIColor(named: "ColorGreen")
    
    func countMiss(_ input : String, whatYouHaveToWrite : String, whatYouAlreadyWrite : String) -> Int {
        var miss = 0
        if Array(input).count < aa-1 {
            if Array(input).count == 0{
                self.aa = 2
            }else{
                self.aa = Array(input).count + 1
            }
        } else if Array(input).count == aa {
            for i in 0 ... aa-2{
                let compare1 = Array(Jamo.getJamo(String(Array(whatYouAlreadyWrite)[i]))).count
                let compare2 = Array(Jamo.getJamo(String(Array(whatYouHaveToWrite)[i]))).count
                
                if compare2 > compare1 {
                    for a in 0...compare1-1{
                        if Array(Jamo.getJamo(String(Array(whatYouAlreadyWrite)[i])))[a] !=
                            Array(Jamo.getJamo(String(Array(whatYouHaveToWrite)[i])))[a]{
                            miss += 1
                        }
                    }
                    miss += compare2 - compare1
                } else if compare2 == compare1 {
                    for a in 0...compare1-1{
                        if Array(Jamo.getJamo(String(Array(whatYouAlreadyWrite)[i])))[a] !=
                            Array(Jamo.getJamo(String(Array(whatYouHaveToWrite)[i])))[a]{
                            miss += 1
                        }
                    }
                } else if compare2 < compare1{
                    for a in 0...compare2-1{
                        if Array(Jamo.getJamo(String(Array(whatYouAlreadyWrite)[i])))[a] !=
                            Array(Jamo.getJamo(String(Array(whatYouHaveToWrite)[i])))[a]{
                            miss += 1
                        }
                    }
                    miss += compare2 - compare1
                }
            }
            print(miss)
            aa += 1
        }
        return miss
    }
    
    func changeColor(_ viewLabel : UILabel, whatYouHaveToWrite : String, whatYouAlreadyWrite : String, textField : UITextField) {
        let attr = NSMutableAttributedString(string: viewLabel.text!)
                        for i in 0...Array(whatYouHaveToWrite).count-1{
                            let completeTrigger = Array(whatYouAlreadyWrite).count
                            if i <= Array(whatYouAlreadyWrite).count-1{
                                if Array(String(whatYouAlreadyWrite))[i] == Array(whatYouHaveToWrite)[i] {
                                    attr.addAttribute(.foregroundColor, value: self.GREEN, range: NSRange(location:i,length:1))
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
                        viewLabel.attributedText = attr
    }
    
//    func calculateSpeed(_ time : String, answerArray : Array<Any>, arrayYouAreWriting : Array<Any>) -> Int {
//        time
//    }
    
}
