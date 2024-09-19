//
//  AuthService.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/18/24.
//

import Foundation

protocol AuthServiceProtocol {
    
    func getCurrentUser() -> (any Credential)?
    
    func signIn(identfier: String, password: String) throws -> any Credential
    
    func signUp(identfier: String, verificationCode: String) throws -> any Credential
}
