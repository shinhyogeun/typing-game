//
//  RecodeCheckor.swift
//  Project_Tadak
//
//  Created by 신효근 on 2021/01/12.
//  Copyright © 2021 Tadak_Team. All rights reserved.
//

import Foundation
import Firebase

class RecodeCheckor {
    private static var ref : DatabaseReference! = Database.database().reference()
    
    static func updateRecode(){
        // 넣을 재료들을 만든다.
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd HH:mm:ss"
        let
        let whenRecodeIsMade = formatter.string(from: Date())
        let when = Firebase.ServerValue.timestamp()
        let recode = GameContents.time
        
        //
        var addedGameScore : [String : Any] = [:]
        var compareArray : [NSString] = []
        var parentChildPost : [NSDictionary] = []

        //임의의 키를 생성한다.
        guard let key = self.ref.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(GameList.name).child(GameContents.name).childByAutoId().key else{ return }
        
        //우리가 넣을 정보
        addedGameScore  = [
                 "TIME" : whenRecodeIsMade,
                 "WHEN" : when,
                 "RECODE" : String(format: "%.2f", recode)
                ]
        
        compareArray.append(String(format: "%.2f", recode) as NSString)
        parentChildPost.append(addedGameScore as NSDictionary)
        
        let rootAndAddedScore = ["/users/\(Auth.auth().currentUser!.uid)/recode/\(GameList.name)/\(GameContents.name)/\(key)" : addedGameScore]
        self.ref.updateChildValues(rootAndAddedScore)
        
        //매번 일어나는 저장
        let bestRecodeRoot : DatabaseQuery! = self.ref.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(GameList.name).child(GameContents.name).child("RECODE")
            
            bestRecodeRoot.observeSingleEvent(of: DataEventType.value) { (snapshot,key) in
                let KING = snapshot.value as? NSDictionary ?? [:]
                if KING != [:] {
                    compareArray.append(KING["RECODE"] as! NSString)
                    parentChildPost.append(KING)
                    // 자신의 기존 기록을 깬 신기록 탄생!!!
                    if compareArray[0].integerValue < compareArray[1].integerValue {
                        
                        let integerPartOfNewRecode = compareArray[0].integerValue
                        let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/recode/\(GameList.name)/\(GameContents.name)/RECODE" : addedGameScore,
                                           "/ranking/\(GameList.name)/\(GameContents.name)/\(integerPartOfNewRecode)/total_\(integerPartOfNewRecode)/\(Auth.auth().currentUser!.uid)" : addedGameScore,
                                           "/ranking/\(GameList.name)/\(GameContents.name)/RECODES/\(Auth.auth().currentUser!.uid)" : addedGameScore]
                        self.ref.updateChildValues(childUpdate)
                        
                        let ROOTFORRANK = self.ref.child("ranking").child(GameList.name).child(GameContents.name).child("\(integerPartOfNewRecode)").child("sum_\(integerPartOfNewRecode)")
                        ROOTFORRANK.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                            let value = (snapshot.value as! NSNumber).intValue
                            let reverseUpdate = ["/ranking/\(GameList.name)/\(GameContents.name)/\(integerPartOfNewRecode)/sum_\(integerPartOfNewRecode)" : value + 1]
                            self.ref.updateChildValues(reverseUpdate) }
                        
                        // 기존의 기록에 대한것들은 없에라!!
                        let intValue2 = compareArray[1].integerValue
                        let ROOTFORRANK2 = self.ref.child("ranking").child(GameList.name).child(GameContents.name).child("\(intValue2)")
                        ROOTFORRANK2.child("sum_\(intValue2)").observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                            let value = (snapshot.value as! NSNumber).intValue
                            let reverseUpdate = ["/ranking/\(GameList.name)/\(GameContents.name)/\(intValue2)/sum_\(intValue2)" : value - 1]
                            self.ref.updateChildValues(reverseUpdate)
                        }
                        ROOTFORRANK2.child("total_\(intValue2)").child(Auth.auth().currentUser!.uid).removeValue()
                    }
                } else {
                    let intValue = compareArray[0].integerValue
                    let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/recode/\(GameList.name)/\(GameContents.name)/RECODE" : addedGameScore,
                                       "/ranking/\(GameList.name)/\(GameContents.name)/\(intValue)/total_\(intValue)/\(Auth.auth().currentUser!.uid)" : addedGameScore,
                                       "/ranking/\(GameList.name)/\(GameContents.name)/RECODES/\(Auth.auth().currentUser!.uid)" : addedGameScore]
                    self.ref.updateChildValues(childUpdate)
                    let ROOTFORRANK = self.ref.child("ranking").child(GameList.name).child(GameContents.name).child("\(intValue)").child("sum_\(intValue)")
                    ROOTFORRANK.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                        let value = (snapshot.value as! NSNumber).intValue
                        let reverseUpdate = ["/ranking/\(GameList.name)/\(GameContents.name)/\(intValue)/sum_\(intValue)" : value+1]
                        self.ref.updateChildValues(reverseUpdate)
                    }
                }
            }

        //오래된 데이터(30일 이상이 된 DATA)를 지우자
        let now = (Date().timeIntervalSince1970) * 1000
        let cutOff = now - 30*24*60*60*1000
        let postRefAboutOldData = ref.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(GameList.name).child(GameContents.name).queryOrdered(byChild: "/WHEN").queryEnding(atValue: cutOff)
        let removePost = ref.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(GameList.name).child(GameContents.name)
        
        postRefAboutOldData.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
            let children : NSEnumerator = snapshot.children
            for child in children {
                let childSnapShot = child as? DataSnapshot
                removePost.child("\(childSnapShot!.key)").removeValue()
            }
        }
    }
}
