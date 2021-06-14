//
//  GameSession.swift
//  GuessGame
//
//  Created by Артём Сарана on 13.06.2021.
//

import Foundation

protocol GameSessionDelegate: AnyObject {
    func endGame(with result: Int)
}

class GameSession {
    weak var gameDelegate: GameSessionDelegate?
    
    private let questions: [Question]
    private var correctAnswersCount: Int = 0
    
    private(set) var is2x2HintUsed = false
    
    var currentQuestionIndex = -1
    
    init(questions: [Question]) {
        self.questions = questions
    }
    
    private func onGameEnd() {
        let correctAnswerPercentage = Int(Float(correctAnswersCount) / Float(questions.count) * 100)
        let record = Record(result: correctAnswerPercentage, date: Date())
        Game.shared.addRecord(record)
        gameDelegate?.endGame(with: correctAnswersCount)
    }
    
    func getNexQuestion() -> Question {
        currentQuestionIndex += 1
        return questions[currentQuestionIndex]
    }
    
    func checkAnswer(answerIndex: Int) -> Bool {
        let question = questions[currentQuestionIndex]
        
        if question.correctAnswerIndex == answerIndex {
            correctAnswersCount += 1
            if currentQuestionIndex == questions.count - 1 {
                onGameEnd()
            } else {
                return true
            }
        } else {
            onGameEnd()
        }
        return false
    }
    
    func get2x2Hint() -> [Int] {
        guard !is2x2HintUsed else { return [] }
        
        is2x2HintUsed = true
        let question = questions[currentQuestionIndex]
        var incorrectAnswers = [Int](0...3)
        incorrectAnswers.remove(at: question.correctAnswerIndex)
        let random = Int(arc4random_uniform(UInt32(incorrectAnswers.count)))
        incorrectAnswers.remove(at: random)
        return incorrectAnswers
    }
}
