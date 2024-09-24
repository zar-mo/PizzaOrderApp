//
//  SignUpViewModel.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/19/24.
//

import Foundation

protocol SignUpViewModel {
    
    var homeViewModel: HomeViewModel? { get }
    func signUp(identifier: String, password: String) async throws
}

class SignUpViewModelImpl : SignUpViewModel {
    
    var authService: AuthServiceProtocol
    var homeViewModel:  HomeViewModel?
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func signUp(identifier: String, password: String) async throws {
        
        do{
            let phoneCredential = PhoneCredential(identifier: identifier, password: password, type: .phonePassword)
            try await authService.signUp(credential: phoneCredential)
            initilizeHomeViewModel()
        }
    }
    
    private func initilizeHomeViewModel() {
        homeViewModel = HomeViewModelImpl(authService: authService)
    }
    
    
}
