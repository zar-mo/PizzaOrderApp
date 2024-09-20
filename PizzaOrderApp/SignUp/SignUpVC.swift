//
//  SignUpVC.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/19/24.
//

import UIKit

class SignUpVC: UIViewController {

    var viewModel: SignUpViewModel?
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    private func presentHomeViewController(with viewModel: HomeViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewVC")
        
        //(homeViewController as? HomeViewVC)?.viewModel = viewModel
        navigationController?.setViewControllers([homeViewController], animated: true)
    }
    
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        guard let phone = phoneTextField.text, !phone.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let  confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty,
              password == confirmPassword else {return}
        
        Task{
            do{
                try await viewModel?.signUp(identifier: phone, password: password)
                if let homeViewModel = viewModel?.homeViewModel{
                    presentHomeViewController(with: homeViewModel)
                }
                
            }catch{
                
                self.showAlert(title: "Sign Up Failed", message: error.localizedDescription)
            }
        }
    }
    

}
