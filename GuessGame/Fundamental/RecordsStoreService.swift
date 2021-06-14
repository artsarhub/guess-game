//
//  RecordsStoreService.swift
//  GuessGame
//
//  Created by Артём Сарана on 13.06.2021.
//

import Foundation

class RecordsStoreService {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private static let recordsKey = "records"
    
    func save(_ records: [Record]) throws {
        let data = try encoder.encode(records)
        UserDefaults.standard.setValue(data, forKey: Self.recordsKey)
    }
    
    func load() throws -> [Record] {
        guard let data = UserDefaults.standard.value(forKey: Self.recordsKey) as? Data else { return [] }
        return try decoder.decode([Record].self, from: data)
    }
}
