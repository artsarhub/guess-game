//
//  GameStrategiesFacade.swift
//  GuessGame
//
//  Created by Артём on 19.06.2021.
//

import Foundation

enum QuestionOrder: Int {
    case serial, random
}

class GameStrategiesFacade {
    private let questionOrder: QuestionOrder
    
    private lazy var questionOrderStrategy: QuestionOrderStrategy = {
        switch questionOrder {
        case .serial: return SerialQuestionOrderStrategy()
        case .random: return RandomQuestionOrderStrategy()
        }
    }()
    
    init(questionOrder: Int) {
        self.questionOrder = QuestionOrder(rawValue: questionOrder) ?? .serial
    }
    
    // MARK: - Public
    
    func getNextQuestionIndex(currentQuestionIndex: Int, questionsCount: Int) -> Int {
        return questionOrderStrategy.getNextQuestionIndex(currentQuestionIndex: currentQuestionIndex, questionsCount: questionsCount)
    }
}
