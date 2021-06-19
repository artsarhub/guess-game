//
//  Question.swift
//  GuessGame
//
//  Created by Артём Сарана on 13.06.2021.
//

import Foundation

struct Question: Codable {
    let text: String
    let answerOptions: [String]
    let correctAnswerIndex: Int
}
