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
            "게임종류" : [
                "한글대전",
                "영어대전",
                "Extra"
            ],
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
        var englishText : Dictionary<String,Array<String>> = [
            "ABC":
            [
                "hello!! we are in middle of Tadak",
                "I really hope we have great chance",
                "i will do my best, and just wait better consequence",
                "we are Tadak Team"
            ],
            "hello guys":
            [
                "I never dreamed about success, I worked for it",
                "Do not try to be original, just try to be good",
                "Do not be afraid to give up the good to go for the great"
            ],
            "Tadak":
            [
                "Tell me what I got to do",
                "The only thing worse than starting something and failing..",
                "is not starting something."
            ]
        ]
    }
    struct Extra {
        var extraText : Dictionary<String,Array<String>> = [
            "Hello World":
            [
                "#includ<iostream>",
                "int main(int argc, char*, argv[]) {",
                "std::cout << \"Hello World\" << std::endl;",
                "return 0;",
                "}",
            ],
            "Binary1":
            [
                "100010101000111101001",
                "11110010101011101010100110",
                "100101010101110111001010100101010"
            ],
            "Random":
            [
                "잃킭엫잏케케후릭켃",
                "할깈킼깈킼깈키키키킼긱킥",
                "아라아랄알라알라아라아랄"
            ],
            "Number":
            [
                "546051561854321516",
                "874189046154785408",
                "087987401056465073",
                "459157017567945762"
            ]
        ]

    }
    
}
