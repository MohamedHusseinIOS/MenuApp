//
//  StorageManager.swift
//  pagination-demo
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    private init(decoder: JSONDecoder = .init(), encoder: JSONEncoder = .init()) {
        self.decoder = decoder
        self.encoder = encoder
    }
    
    func saveData<T: Codable>(value: T, for key: String) throws {
        let data = try encoder.encode(value)
        if DBManager.shared.getValueBy(key: key) != Data("".utf8){
            DBManager.shared.update(value: data, forKey: key)
        } else {
            DBManager.shared.insert(value: data, forKey: key)
        }
    }
    
    func fetchData<T: Codable>(for key: String) throws -> T {
        let data = DBManager.shared.getValueBy(key: key)
        let model = try decoder.decode(T.self, from: data)
        return model
    }
}
