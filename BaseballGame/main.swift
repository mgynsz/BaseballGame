//
//  main.swift
//  BaseballGame
//
//  Created by David Jang on 3/12/24.
//

import Foundation

class BaseballGame {
    
    var answer: [Int] = []
    
    // 게임시작
    func start() {
        
        // 시작과 동시에 정답을 생성
        answer = makeAnswer()
        print("< 게임을 시작합니다 >")
        
        // 조건과 맞지 않는 입력값을 무한하게 알려주자!
        while true {
            print("숫자를 입력하세요")
            guard let input = readLine(), checkUserNumber(input) else {
                print("올바르지 않은 입력값입니다")
                continue
            }
            
            // 사용자 입력 값 Int로 변환 후 담기
            let userNum = input.compactMap { Int(String($0)) }
            let result = compareNumbers(userNum)
            
            // 스트라이크/볼 결과 알려주기
            if result.s == 3 {
                print("정답입니다! \n")
                break
            } else if result.s == 0 && result.b == 0 {
                print("Nothing \n")
            } else {
                print("\(result.s)스트라이크 \(result.b)볼 \n")
            }
            
        }
    }
    
    // 1...9 중에 중복되지 않게 3개의 숫자 배열에 담기
    func makeAnswer() -> [Int] {
        
        let numbers = Array(1...9)
        return Array(numbers.shuffled().prefix(3))
    }
    
    // 숫자 비교하기
    func compareNumbers(_ userNumber: [Int]) -> (s: Int, b: Int) {
        
        var strike = 0
        var ball = 0
        
        // 사용자 숫자를 튜플로 바꿔 인덱스와 숫자를 비교
        for (index, number) in userNumber.enumerated() {
            if answer[index] == number {
                strike += 1
            } else if answer.contains(number) {
                ball += 1
            }
        }
        return (strike, ball)
    }
    
    // 사용자 숫자를 게임 조건에 맞는지 확인 readLine()으로 입력 받기 때문에 파라미터가 String 타입
    func checkUserNumber(_ input: String) -> Bool {
        let numbers = input.compactMap { Int(String($0)) }
        return input.count == 3 && !input.contains("0") && Set(numbers).count == input.count
    }
}

let game = BaseballGame()
game.start()

