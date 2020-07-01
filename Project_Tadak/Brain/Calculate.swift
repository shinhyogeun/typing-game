//
//  Calculate.swift
//  Project_Tadak
//
//  Created by 신효근 on 2020/05/30.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import Foundation

struct Calculate {
    
    var miss = 0
    
    mutating func calculateHowManyMissYouMake(_ original : String,  whatYouAreWriting: String) -> Int{
        
        //오타의 종류에는 3가지가 있다.
        //1. 쓸 것을 아무것도 쓰지 않았을 때 => 배열의 길이가 달라져서 쓰지 않은 부분뒤로 모두 틀리게 된다. => 아무것도 쓰지않은 곳이 발각되면 우리가 무엇을 넣어서 계속 나아갈까?
        //2. 쓸 것에 엉뚱한 것을 쓸 때 => 이것은 배열의 길이가 똑같이 때문에 우리가 오타의 갯수를 찾기가 쉽다.
        //3. 안 써야 할 곳에 무엇을 쓸 때 => 이것도 배열의 길이가 달려져서 더 쓴 부분뒤로 모두 틀리게 된다. => 무엇을 더 쓴 곳이 있으면 그것을 지울까..?
        // 안녕하세요 =  ["ㅇ","ㅏ","ㄴ","ㄴ","ㅕ"]
        //  녕하세요 = [" ","ㄴ","ㅕ"]
        let jamoYouAreWriting2 = Jamo.getJamo(whatYouAreWriting)
        let jamoYouHaveToWriting2 = Jamo.getJamo(original)
        
        let originalJamoArray = Array(jamoYouHaveToWriting2)
        let jamoYouAreWriting = Array(jamoYouAreWriting2)
        
        miss = 0
        
        for number in 0..<jamoYouAreWriting.count{
            if jamoYouAreWriting[number] != originalJamoArray[number]{
                if jamoYouAreWriting[number] == " "{
//                    여기는 큰 실수가 일어난 구간이지. 잘못으로 스페이스바를 해서 한 글자를 통채로 안씀..
                }
//                print(jamoYouAreWriting[number])
//                print(originalJamoArray[number])
                self.miss = miss + 1
            }
        }
        
        print(miss)
        
        return miss
        
    }
    
//    func calculateSpeed(_ time : String, answerArray : Array<Any>, arrayYouAreWriting : Array<Any>) -> Int {
//        time
//    }
}
