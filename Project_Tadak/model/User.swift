//
//  user.swift
//  Project_Tadak
//
//  Created by 신효근 on 2021/01/12.
//  Copyright © 2021 Tadak_Team. All rights reserved.
//

import Foundation
import Firebase

class User {
    private var ref : DatabaseReference = Database.database().reference()
    
    func getNickNameAndThen (_ doNextStep : @escaping (_ nickNameToss:Dictionary<String,String>, _ nickName:String) -> Dictionary<String,String>) -> Void {
        var a : Dictionary<String,String> = [:]
        var b :Dictionary<String,String> = [:]
            ref.child("users")
                .child(Auth.auth().currentUser!.uid)
                .child("nickname")
                .observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                let children : NSEnumerator = snapshot.children
                for (child) in children {
                    let childSnapShot = child as? DataSnapshot
                    DispatchQueue.main.async {
                        b = doNextStep(a,childSnapShot?.value as? String ?? "")
                    }
                }
            }
        
    }
    
    func leaveGame () -> Void {
        
    }
}
