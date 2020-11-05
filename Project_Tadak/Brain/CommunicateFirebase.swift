//
//  CommunicateFirebase.swift
//  Project_Tadak
//
//  Created by 신효근 on 2020/10/30.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import Foundation
import Firebase

class CommunicateFirebase
{
    var ref : DatabaseReference = Database.database().reference()
    
    func findOutAndUpdate(ref:DatabaseReference, originRecode : NSNumber, newRecode : Double) {
        
        let whatOriginRoom : Int = Int(originRecode)
        let whatRoom : Int = Int(newRecode)

        
        // 기존의 정보 없에기
        
        
        
        
        // 새로운 업데이트
        
        
        
        
        
    }
    
}
