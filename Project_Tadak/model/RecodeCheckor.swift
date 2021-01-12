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
    private var user : User = User()
    private var ref : DatabaseReference = Database.database().reference()
    
    // 정말 최악인 코드이다.. 하지만 RxSwift를 쓰기 전에는 이렇게 하는 수 뿐이다.
    func recodeCompareAndUpdate() -> Void {
        ref.child("ranking")
            .child(GameList.name)
            .child(GameContents.name)
            .queryOrdered(byChild: "/RECODE")
            .queryLimited(toFirst: 50)
            .observeSingleEvent(of: DataEventType.value) { (snapShot,key) in
                var empty : Array<NSDictionary> = []
                let children : NSEnumerator = snapShot.children
                for child in children {
                    let childSnapShot = child as? DataSnapshot
                    let childPost : NSDictionary = (childSnapShot?.value as? NSDictionary)!
                    empty.append(childPost)
                }
                print(empty)
            }
        }
}
