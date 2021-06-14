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

class Game {
    static let shared: Game = Game()
    
    private(set) var records: [Record] = []
    private let recordsStoreService = RecordsStoreService()
    
    var session: GameSession?
    
    private init() {
        restoreState()
    }
    
    private func restoreState() {
        records = ((try? recordsStoreService.load()) ?? []).sorted { $0.date > $1.date }
    }
    
    func addRecord(_ record: Record) {
        records.insert(record, at: 0)
        try? recordsStoreService.save(records)
    }
    
    func clearRecords() {
        records = []
        try? recordsStoreService.save(records)
    }
}
