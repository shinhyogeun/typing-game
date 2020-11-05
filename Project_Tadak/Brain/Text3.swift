//
//  Text2.swift
//  Project_Tadak
//
//  Created by Min_MacbookPro on 2020/08/16.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import Foundation
import Firebase

class Text3 {
    
    var title1: String = "sss"
    var textArray1 : [String] = ["aaa","bbb","Cccc","asdasd"]
    var ref = Database.database().reference()
    
    func getTitle(num: Int) -> String
    {
        print(title1)
        return title1
    }
    func getData(num: Int) -> Array<String>
    {
        let postRef : DatabaseQuery! = ref.child("users").child(Auth.auth().currentUser!.uid).child("한국어게임")
        postRef.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
            let children : NSEnumerator = snapshot.children
            for (child) in children {
                let childSnapShot = child as? DataSnapshot
                let a = (childSnapShot?.value as? NSArray)! as! Array<String>
                MyVariables.completeArray = (childSnapShot?.value as? NSArray)! as! Array<String>
                DispatchQueue.main.async {
                    self.textArray1 = MyVariables.completeArray
                    print("1",self.textArray1)
                }
                print("2",self.textArray1)
            }
        }
        return textArray1
    }
    
//    func loadComplete() -> Bool
//    {
//        var check:Bool = false
//        let postRef : DatabaseQuery! = ref.child("users").child(Auth.auth().currentUser!.uid).child("한국어게임")
//        postRef.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
//            let group = DispatchGroup()
//            let children : NSEnumerator = snapshot.children
//            group.enter()
//            for (child) in children {
//                let childSnapShot = child as? DataSnapshot
//                let a = (childSnapShot?.value as? NSArray)! as! Array<String>
//                MyVariables.completeArray = (childSnapShot?.value as? NSArray)! as! Array<String>
////                print(MyVariables.completeArray,"12")
//                print("for 문 안에서 출력")
//                print(MyVariables.completeArray,"12")
//            }
//            self.textArray1 = MyVariables.completeArray
//            check = true
//            print("for문 밖에서 출력")
//            print(self.textArray1)
//        }
//        return check
//    }
    
}

struct MyVariables {
    static var completeArray : Array<String> = []
    static var completeGameArray : Array<String> = []
    static var gameTopic : String = ""
    static var gameName : String = ""
    static var gameTopicArr = ["한글대전","영어대전","Extar"]
    static var gameKoreaArr = ["아무노래","타닥","애국가","다시 여기 바닷가"]
    static var rakingRangeArr = [00,10,20,30,40,50,60,70,80,90]
}
