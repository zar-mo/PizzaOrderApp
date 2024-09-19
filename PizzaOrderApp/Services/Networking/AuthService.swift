//
//  AuthService.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/18/24.
//

import Foundation

protocol AuthServiceProtocol {
    
    func getCurrentUser<T: Credential>() async throws -> T
    func signIn(identifier: String, password: String) async throws
    func signUp(identifier: String, password: String) async throws
    func signOut(key: String) async throws
}


class AuthService: AuthServiceProtocol {
    
    private let credentialStorage: CredentialStorage
    
    init(credentialStorage:  CredentialStorage) {
        self.credentialStorage = credentialStorage
    }
    
    func getCurrentUser<T: Credential>() async throws -> T {
        
        return try credentialStorage.load(objectType: T.self , key: "currentUser")
    }
    
    func signIn(identifier: String, password: String) async throws {
        
        do{
            let existingPassword = try credentialStorage.load(objectType: String.self , key: identifier)
            
            if existingPassword == password {
                let currentUser = PhoneCredential(identifier: identifier, password: password, type: .phonePassword)
                try credentialStorage.save(object: currentUser, key: "currentUser")
            }else {
                throw TemporaryErrorType.dataNotFound
            }
        }
      
    }
    
    func signUp(identifier: String, password: String) async throws {
        
        do{
            let currentUser = PhoneCredential(identifier: identifier, password: password, type: .phonePassword)
            try credentialStorage.save(object: currentUser, key: "currentUser")
            try credentialStorage.save(object: identifier, key: password)
        }
       
    }
    
    func signOut(key: String) async throws {
        
         credentialStorage.remove(key: "currentUser")
    }
    

}

