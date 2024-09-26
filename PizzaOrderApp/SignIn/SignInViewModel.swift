//
//  SignInViewModel.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/19/24.
//

import Foundation

enum SignInUpdateType {
    case homeViewDidSet
    case singUpDidSet
}

protocol SignInViewModel {
    
    var homeViewModel: HomeViewModel? { get }
    func phoneChanged(phone: String?)
    func signInButtonTapped(identifier: String, password: String) async throws
    func signUpViewModel() -> SignUpViewModel
    var onUpdate : ((SignInUpdateType) -> Void)? {get set}
}

class SignInViewModelImpl: SignInViewModel {
    
    var onUpdate: ((SignInUpdateType) -> Void)?
    var homeViewModel: HomeViewModel? {
        didSet { onUpdate?(.homeViewDidSet)}
       
    }
    private let authService:  AuthServiceProtocol
    private var phone: String?
    private var password: String?
    
    
    init(authService:  AuthServiceProtocol) {
        self.authService = authService
    }
    

    func phoneChanged(phone: String?) {
        
    }
    
    func signInButtonTapped(identifier: String, password: String) async throws{
        
        do{
            let phoneCredential = PhoneCredential(identifier: identifier, password: password, type: .phonePassword)
            try await authService.signIn(credential: phoneCredential)
            initilizeHomeViewModel()
        }
        
        
    }
    
    func signUpViewModel() ->  SignUpViewModel {
        
        return SignUpViewModelImpl(authService: authService)
    }
    
    private func initilizeHomeViewModel() {
        homeViewModel = HomeViewModelImpl(authService: authService)
    }
    
}
