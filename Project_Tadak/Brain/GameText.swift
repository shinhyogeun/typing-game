//
//  GameText.swift
//  Project_Tadak
//
//  Created by 신효근 on 2020/10/22.
//  Copyright © 2020 Tadak_Team. All rights reserved.
//

import Foundation

class GameText {
    struct gameTitle {
        var gameTitle : Dictionary<String,Array<String>> = [
            "한글대전" : [
                "애국가",
                "다시 여기 바닷가",
                "아무노래",
                "타닥"
            ],
            "영어대전" : [
                "ABC",
                "hello guys",
                "Tadak"
            ],
            "Extra" : [
                "Hello World",
                "Binary1",
                "Random",
                "Number"
            ]
        ]
    }
    struct Korea {
        var koreaText : Dictionary<String,Array<String>> = [
            "애국가":
            [
                "동해물과 백두산이 마르고 닳도록",
                "하느님이 보우하사 우리나라 만세",
                "무궁화 삼천리 화려강산",
                "대한사람 대한으로 길이 보전하세",
                "남산위에 저 소나무 철갑을 두른듯",
                "바람서리 불변함은 우리 기상일세"
            ],
            "다시 여기 바닷가":
            [
                "예아! 호우! 예예예~",
                "싹쓰리 인더 하우스",
                "커커커커커몬! 싹!쓰리!투 렛츠고!",
                "나 다시 또 설레어",
                "이렇게 너를 만나서",
                "함께 하고 있는 지금 이 공기가",
            ],
            "아무노래":
            [
                "왜들 그리 다운돼있어?",
                "뭐가 문제야 say something",
                "분위기가 겁나 싸해",
                "요새는 이런 게 유행인가",
                "왜들 그리 재미없어?",
                "아 그건 나도 마찬가지",
                "Tell me what I got to do",
                "급한 대로 블루투스 켜"
            ],
            "타닥":
            [
                "안녕하세요 저희는 타닥입니다.",
                "저희는 올해 안에 출시합니다.",
                "광고 환영합니다~!"
            ]
        ]
    }
    struct English {
        //영어 관련 게임 text
    }
    struct Wierd {
        //다양한 게임 text
    }
    
}
