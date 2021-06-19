//
//  StoreService.swift
//  GuessGame
//
//  Created by Артём on 19.06.2021.
//

import Foundation

enum StoreKey: String {
    case records = "records"
    case settings = "settings"
    case questions = "questions"
}

class StoreService {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func save<T: Codable>(_ savingData: T, for key: StoreKey) throws {
        let data = try encoder.encode(savingData)
        UserDefaults.standard.setValue(data, forKey: key.rawValue)
    }
    
    func load<T: Codable>(for key: StoreKey) throws -> T? {
        guard let data = UserDefaults.standard.value(forKey: key.rawValue) as? Data else { return nil }
        return try decoder.decode(T.self, from: data)
    }
}
