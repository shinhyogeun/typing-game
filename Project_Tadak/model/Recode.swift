//
//  UpdateRecode.swift
//  Project_Tadak
//
//  Created by 신효근 on 2021/01/04.
//  Copyright © 2021 Tadak_Team. All rights reserved.
//

import Foundation
import Firebase

class Recode {
    private static var hyogeun : DatabaseReference! = Database.database().reference()
    
    static func updateRecode(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd HH:mm:ss"
        let whenRecodeIsMade = formatter.string(from: Date())
        let when = Firebase.ServerValue.timestamp()
        let recode = GameContents.time
        
        var post : [String : Any] = [:]
        var forChange : [NSString] = []
        var parentChildPost : [NSDictionary] = []

        guard let key = self.hyogeun.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(GameList.name).child(GameContents.name).childByAutoId().key else{ return }
                post  = [
                         "TIME" : whenRecodeIsMade,
                         "WHEN" : when,
                         "RECODE" : String(format: "%.2f", recode)
                        ]
        forChange.append(String(format: "%.2f", recode) as NSString)
        parentChildPost.append(post as NSDictionary)
        
        let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/recode/\(GameList.name)/\(GameContents.name)/\(key)" : post]
        self.hyogeun.updateChildValues(childUpdate)
        
        //매번 일어나는 저장
        let KINGROOT : DatabaseQuery! = self.hyogeun.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(GameList.name).child(GameContents.name).child("RECODE")
            
            KINGROOT.observeSingleEvent(of: DataEventType.value) { (snapshot,key) in
                let KING = snapshot.value as? NSDictionary ?? [:]
                if KING != [:] {
                    forChange.append(KING["RECODE"] as! NSString)
                    parentChildPost.append(KING)
                    // 드디어 자신의 모든 기록을 깬 신기록 탄생!!!
                    if forChange[0].integerValue < forChange[1].integerValue {
                        
                        let intValue = forChange[0].integerValue
                        let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/recode/\(GameList.name)/\(GameContents.name)/RECODE" : post,
                                           "/ranking/\(GameList.name)/\(GameContents.name)/\(intValue)/total_\(intValue)/\(Auth.auth().currentUser!.uid)" : post,
                                           "/ranking/\(GameList.name)/\(GameContents.name)/RECODES/\(Auth.auth().currentUser!.uid)" : post]
                        self.hyogeun.updateChildValues(childUpdate)
                        
                        let ROOTFORRANK = self.hyogeun.child("ranking").child(GameList.name).child(GameContents.name).child("\(intValue)").child("sum_\(intValue)")
                        ROOTFORRANK.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                            let value = (snapshot.value as! NSNumber).intValue
                            let reverseUpdate = ["/ranking/\(GameList.name)/\(GameContents.name)/\(intValue)/sum_\(intValue)" : value+1]
                            self.hyogeun.updateChildValues(reverseUpdate) }
                        
                        // 기존의 기록에 대한것들은 없에라!!
                        let intValue2 = forChange[1].integerValue
                        let ROOTFORRANK2 = self.hyogeun.child("ranking").child(GameList.name).child(GameContents.name).child("\(intValue2)")
                        ROOTFORRANK2.child("sum_\(intValue2)").observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                            let value = (snapshot.value as! NSNumber).intValue
                            let reverseUpdate = ["/ranking/\(GameList.name)/\(GameContents.name)/\(intValue2)/sum_\(intValue2)" : value-1]
                            self.hyogeun.updateChildValues(reverseUpdate)
                        }
                        ROOTFORRANK2.child("total_\(intValue2)").child(Auth.auth().currentUser!.uid).removeValue()
                    }
                } else {
                    let intValue = forChange[0].integerValue
                    let childUpdate = ["/users/\(Auth.auth().currentUser!.uid)/recode/\(GameList.name)/\(GameContents.name)/RECODE" : post,
                                       "/ranking/\(GameList.name)/\(GameContents.name)/\(intValue)/total_\(intValue)/\(Auth.auth().currentUser!.uid)" : post,
                                       "/ranking/\(GameList.name)/\(GameContents.name)/RECODES/\(Auth.auth().currentUser!.uid)" : post]
                    self.hyogeun.updateChildValues(childUpdate)
                    let ROOTFORRANK = self.hyogeun.child("ranking").child(GameList.name).child(GameContents.name).child("\(intValue)").child("sum_\(intValue)")
                    ROOTFORRANK.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                        let value = (snapshot.value as! NSNumber).intValue
                        let reverseUpdate = ["/ranking/\(GameList.name)/\(GameContents.name)/\(intValue)/sum_\(intValue)" : value+1]
                        self.hyogeun.updateChildValues(reverseUpdate)
                    }
                }
            }

        //오래된 데이터(30일 이상이 된 DATA)를 지우자
        let now = (Date().timeIntervalSince1970) * 1000
        let cutOff = now - 30*24*60*60*1000
        let postRefAboutOldData = hyogeun.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(GameList.name).child(GameContents.name).queryOrdered(byChild: "/WHEN").queryEnding(atValue: cutOff)
        let removePost = hyogeun.child("users").child(Auth.auth().currentUser!.uid).child("recode").child(GameList.name).child(GameContents.name)
        
        postRefAboutOldData.observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
            let children : NSEnumerator = snapshot.children
            for child in children {
                let childSnapShot = child as? DataSnapshot
                removePost.child("\(childSnapShot!.key)").removeValue()
            }
        }
    }
}
