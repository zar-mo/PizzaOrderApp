//
//  Credential.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/18/24.
//

import Foundation

enum CredentialType: Codable {
    case phonePassword
    case emailPassword
    case usernamePassword

}

protocol Credential: Codable, Hashable {
    
    var identifier: String {get set}
    var password: String {get set}
    var type: CredentialType {get set}

}

struct PhoneCredential: Credential {
    
    var identifier: String
    var password: String
    var type: CredentialType
  
}
