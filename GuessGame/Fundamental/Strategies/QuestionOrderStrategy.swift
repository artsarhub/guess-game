//
//  QuestionOrderStrategy.swift
//  GuessGame
//
//  Created by Артём on 17.06.2021.
//

import Foundation

protocol QuestionOrderStrategy: AnyObject {
    func getNextQuestionIndex(currentQuestionIndex: Int, questionsCount: Int) -> Int
}

final class SerialQuestionOrderStrategy: QuestionOrderStrategy {
    func getNextQuestionIndex(currentQuestionIndex: Int, questionsCount: Int) -> Int {
        return currentQuestionIndex + 1
    }
}

final class RandomQuestionOrderStrategy: QuestionOrderStrategy {
    private var usedQuestionsIndexes: [Int] = []
    
    func getNextQuestionIndex(currentQuestionIndex: Int, questionsCount: Int) -> Int {
        let indexes = [Int](0..<questionsCount).filter { !usedQuestionsIndexes.contains($0) }
        let randomIndex = Int(arc4random_uniform(UInt32(indexes.count)))
        usedQuestionsIndexes.append(indexes[randomIndex])
        return indexes[randomIndex]
    }
}
