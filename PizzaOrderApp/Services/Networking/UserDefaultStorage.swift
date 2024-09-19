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
    
    
   
    func save<T: Codable>(object: T, key: String) throws
    
    func load<T: Codable>(objectType: T.Type, key: String) throws -> T
    
    func remove(key: String)
   
}

class CredentialStorage: UserDefaultStorageProtocol {
   
}


// MARK: default implementations of save and load methods
extension UserDefaultStorageProtocol {
    
    func save<T: Codable>(object: T, key: String) throws  {
        let jsonData = try JSONEncoder().encode(object)
        UserDefaults.standard.setValue(jsonData, forKey: key)
    }
    
    func load<T: Codable>(objectType: T.Type, key: String) throws -> T {
        guard let jsonData = UserDefaults.standard.data(forKey: key),
              let decodedObject = try? JSONDecoder().decode(objectType, from: jsonData) else {
            throw TemporaryErrorType.dataNotFound
        }
        return decodedObject
    }
    
    func remove(key: String){
        UserDefaults.standard.removeObject(forKey: key)
    }

}

        
        
