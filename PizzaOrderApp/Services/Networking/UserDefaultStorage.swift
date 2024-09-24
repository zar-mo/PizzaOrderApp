//
//  UserDefaultStorage.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/18/24.
//

import Foundation

enum TemporaryErrorType: Error {
    case dataNotFound
}

protocol UserDefaultStorageProtocol {
    func save(object: Codable, key: String) throws
    func load<T: Codable>(objectType: T.Type, key: String) throws -> T
    func remove(key: String)
}

class CredentialStorage: UserDefaultStorageProtocol {
    
}

// MARK: Default implementations of save and load methods
extension UserDefaultStorageProtocol {
    
    func save(object: Codable, key: String) throws {
        let jsonData = try JSONEncoder().encode(object)
        UserDefaults.standard.setValue(jsonData, forKey: key)
    }
    
    func load<T: Codable>(objectType: T.Type, key: String) throws -> T {
        print("entered object:   \(objectType)   key:  \(key)")
        guard let jsonData = UserDefaults.standard.data(forKey: key),
              let decodedObject = try? JSONDecoder().decode(T.self, from: jsonData) else {
            throw TemporaryErrorType.dataNotFound
        }
        print("key:   \(key)    object:   \(decodedObject)")
        return decodedObject
    }
    
    func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
