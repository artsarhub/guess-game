//
//  Game.swift
//  GuessGame
//
//  Created by Артём Сарана on 13.06.2021.
//

import Foundation

struct Record: Codable {
    let result: Int
    let date: Date
}

struct Settings: Codable {
    var questionOrder: Int = 0
}

class Game {
    static let shared: Game = Game()
    
    private(set) var records: [Record] = []
    private(set) var userQuestions: [Question] = []
    private(set) var settings = Settings()
    private let storeService = StoreService()
    
    var session: GameSession?
    
    private init() {
        restoreState()
    }
    
    private func restoreState() {
        records = ((try? storeService.load(for: .records)) ?? []).sorted { $0.date > $1.date }
        settings = (try? storeService.load(for: .settings)) ?? Settings()
        userQuestions = (try? storeService.load(for: .questions)) ?? []
    }
    
    // MARK: - Public
    
    func addRecord(_ record: Record) {
        records.insert(record, at: 0)
        try? storeService.save(records, for: .records)
    }
    
    func clearRecords() {
        records = []
        try? storeService.save(records, for: .records)
    }
    
    func saveSettings(_ settings: Settings) {
        self.settings = settings
        try? storeService.save(settings, for: .settings)
    }
    
    func addUserQuestion(_ question: Question) {
        userQuestions.append(question)
        try? storeService.save(userQuestions, for: .questions)
    }
}
