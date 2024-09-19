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
    
    associatedtype object: Codable
   
    func save(object: object, key: String) throws
    
    func load(objectType: object.Type, key: String) throws -> object
    
    func remove(key: String)
   
}

class CredentialStorage<T: Credential>: UserDefaultStorageProtocol {
    typealias object = T
}


// MARK: default implementations of save and load methods
extension UserDefaultStorageProtocol {
    
    func save(object: object, key: String) throws  {
        let jsonData = try JSONEncoder().encode(object)
        UserDefaults.standard.setValue(jsonData, forKey: key)
    }
    
    func load(objectType: object.Type, key: String) throws -> object {
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

        
        
