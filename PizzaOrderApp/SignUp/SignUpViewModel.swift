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
    
    var authService: AuthService
    var homeViewModel:  HomeViewModel?
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func signUp(identifier: String, password: String) async throws {
        
        do{
            try await authService.signUp(identifier: identifier, password: password)
            initilizeHomeViewModel()
        }
    }
    
    private func initilizeHomeViewModel() {
        homeViewModel = HomeViewModelImpl()
    }
    
    
}
