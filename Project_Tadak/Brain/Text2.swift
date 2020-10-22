//
//  Text2.swift
//  Project_Tadak
//
//  Created by Min_MacbookPro on 2020/08/16.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import Foundation

class Text2 {
    var title1: String = "애국가"
    var title2: String = "다시 여기 바닷가"
    var title3: String = "아무노래"
    
    var textArray1 =
        [
            "동해물과 백두산이 마르고 닳도록",
            "하느님이 보우하사 우리나라 만세",
            "무궁화 삼천리 화려강산",
            "대한사람 대한으로 길이 보전하세",
            "남산위에 저 소나무 철갑을 두른듯",
            "바람서리 불변함은 우리 기상일세"
        ]
    var textArray2 =
        [
            "예아! 호우! 예예예~",
            "싹쓰리 인더 하우스",
            "커커커커커몬! 싹!쓰리!투 렛츠고!",
            "나 다시 또 설레어",
            "이렇게 너를 만나서",
            "함께 하고 있는 지금 이 공기가",
        ]
    var textArray3 =
        [
            "왜들 그리 다운돼있어?",
            "뭐가 문제야 say something",
            "분위기가 겁나 싸해",
            "요새는 이런 게 유행인가",
            "왜들 그리 재미없어?",
            "아 그건 나도 마찬가지",
            "Tell me what I got to do",
            "급한 대로 블루투스 켜"
        ]
    func getTitle(num: Int) -> String
    {
        switch num {
        case 1:
            return title1
        case 2:
            return title2
        case 3:
            return title3
        default:
            return title1
        }
    }
    func getData(num: Int) -> Array<String>
    {
        switch num {
        case 1:
            return textArray1
        case 2:
            return textArray2
        case 3:
            return textArray3
        default:
            return textArray1
        }
    }
}
