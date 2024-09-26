//
//  AuthService.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/18/24.
//

import Foundation

protocol AuthServiceProtocol {
    func getCurrentUser<T: Credential>() async throws -> T
    func signIn<T: Credential>(credential: T) async throws
    func signUp<T: Credential>(credential: T) async throws
    func signOut() async throws
}

class AuthService: AuthServiceProtocol {
    
    
    var credentialStorage: UserDefaultStorageProtocol
    
    init(credentialStorage: UserDefaultStorageProtocol) {
        self.credentialStorage = credentialStorage
    }
    
    func getCurrentUser<T: Credential>() async throws -> T {
        return try credentialStorage.load(objectType: T.self, key: "currentUser")
    }
    
    func signIn<T: Credential>(credential: T) async throws {
        
        do {
            
            let existingCredential = try credentialStorage.load<T>(objectType: T.self, key: credential.identifier)
            if existingCredential.password == credential.password {
               try credentialStorage.save(object: credential, key: "currentUser")
            } else {
                throw TemporaryErrorType.dataNotFound
            }
        } catch {
            throw TemporaryErrorType.dataNotFound
        }
    }
    
    func signUp<T: Credential>(credential: T) async throws {

        try credentialStorage.save(object: credential, key: "currentUser")
        try credentialStorage.save(object: credential, key: credential.identifier)
    }
    
    func signOut() async throws {
        credentialStorage.remove(key: "currentUser")
    }
}
