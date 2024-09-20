//
//  SplashVC.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/19/24.
//

import UIKit

class SplashVC: UIViewController {
    
    var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAuth()
        
    }
    
}

extension SplashVC {
    
    func checkAuth() {
        navigateToSignInView()
        
        Task {
            do {
                let currentUser: PhoneCredential = try await authService.getCurrentUser()
                print(currentUser)
                navigateToHomeView(with: currentUser)
                
            } catch {
                navigateToSignInView()
            }
        }
    }
    
    func navigateToHomeView(with user: PhoneCredential) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewVC") as? HomeViewVC else{ return}
        navigationController?.setViewControllers([homeViewController], animated: true)
        
    }
    
    func navigateToSignInView() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let signInViewController = storyboard.instantiateViewController(withIdentifier: "SignInViewVC") as? SignInViewController else{ return}
        if let authService = authService{
            signInViewController.viewModel = SignInViewModelImpl(authService: authService)
        }
        navigationController?.setViewControllers([signInViewController], animated: true)
        
    }
}
