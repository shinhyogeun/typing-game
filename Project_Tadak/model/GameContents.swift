//
//  GameContents.swift
//  Project_Tadak
//
//  Created by 신효근 on 2021/01/04.
//  Copyright © 2021 Tadak_Team. All rights reserved.
//

import Foundation
import Firebase

struct GameContents {
    
    static var name : String = "Empty"
    static var body : [String] = []
    static var time : Double = 00.00
    static var index : Int = 0
    static private var ref : DatabaseReference = Database.database().reference()
    
    static func getContentsAndThen (indexPathRow:Int, completion : @escaping () -> Void) -> Void {
        self.name = GameList.body[indexPathRow]
        self.makeBodyEmpty()
        ref.child("game")
            .child(GameList.name)
            .child(GameContents.name)
            .observeSingleEvent(of: DataEventType.value) { (snapshot, key) in
                let children : NSEnumerator = snapshot.children
                
                for (child) in children {
                    let childSnapShot = child as? DataSnapshot
                    let childPost : NSString = (childSnapShot?.value as? NSString)!
                    self.body.append(childPost as String)
                }
                
                DispatchQueue.main.async {
                    completion()
                }
        }
    }
    
    static func updateTime () -> Void {
        self.time += 0.01
    }

    static func addTime(_ time: Double) -> Double {
        self.time += time
        
        return self.time
    }
    
    static func makeBodyEmpty () -> Void {
        self.body = []
    }
    
    static func reset () -> Void {
        self.name = "Empty"
        self.body = []
        self.index = 0
        self.time = 00.00
    }
    
    static func updateIndex () -> Void {
        self.index += 1
    }
    
    static func isTimeOver () -> Bool{
        return time > 99.99
    }
    
}
