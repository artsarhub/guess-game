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
    
    private let gameStrategiesFacade: GameStrategiesFacade
    private let questions: [Question]
    private var usedQuestionIndexes: [Int] = []
    private var correctAnswersCount: Int = 0
    
    private(set) var is2x2HintUsed = false
    let questionNumber: Observable<Int> = Observable(0)
    let gamePassPercentage: Observable<Int> = Observable(0)
    
    private var currentQuestionIndex = -1 {
        didSet {
            questionNumber.value = usedQuestionIndexes.count + 1
            gamePassPercentage.value = Int(Float(usedQuestionIndexes.count) / Float(questions.count) * 100)
        }
    }
    
    init(questions: [Question], gameStrategiesFacade: GameStrategiesFacade) {
        self.questions = questions
        self.gameStrategiesFacade = gameStrategiesFacade
    }
    
    private func onGameEnd() {
        let correctAnswerPercentage = Int(Float(correctAnswersCount) / Float(questions.count) * 100)
        let record = Record(result: correctAnswerPercentage, date: Date())
        Game.shared.addRecord(record)
        gameDelegate?.endGame(with: correctAnswersCount)
    }
    
    // MARK: - Public
    
    func getNextQuestion() -> Question {
        let nextIndex = gameStrategiesFacade.getNextQuestionIndex(currentQuestionIndex: currentQuestionIndex, questionsCount: questions.count)
        currentQuestionIndex = nextIndex
        return questions[nextIndex]
    }
    
    func checkAnswer(answerIndex: Int) -> Bool {
        let question = questions[currentQuestionIndex]
        
        if question.correctAnswerIndex == answerIndex {
            usedQuestionIndexes.append(currentQuestionIndex)
            correctAnswersCount += 1
            if usedQuestionIndexes.count == questions.count {
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
