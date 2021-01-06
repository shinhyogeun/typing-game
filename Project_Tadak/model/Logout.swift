//
//  Logout.swift
//  Project_Tadak
//
//  Created by 신효근 on 2021/01/04.
//  Copyright © 2021 Tadak_Team. All rights reserved.
//

import Foundation
import Firebase

class Logout {
    static func tryLogout() -> Void{
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("로그아웃을 할 수 없습니다.", signOutError)
        }
    }
}
