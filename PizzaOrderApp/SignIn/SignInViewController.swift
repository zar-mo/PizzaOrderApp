//
//  SignInViewController.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/18/24.
//

import UIKit

class SignInViewController: UIViewController {

    var viewModel: SignInViewModel?
    
    @IBOutlet weak var SignInButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var welcomeImageView: UIImageView! {
        
        didSet {
            welcomeImageView.image =  UIImage(named: "chinese1")
        }
    }
    
    
    @IBOutlet weak var loginContainer: UIView! {
        didSet {
            loginContainer.layer.cornerRadius = 20
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
    }
    
    @IBAction func forgetPassButton(_ sender: UIButton) {
    }
    
    @IBAction func SignInButtonAction(_ sender: UIButton) {
        
        signInAction()
    }
    
    @IBSegueAction func signUpSegue(_ coder: NSCoder) -> SignUpVC? {
        return SignUpVC()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let signUpViewController = segue.destination as? SignUpVC
        signUpViewController?.viewModel = viewModel?.signUpViewModel()
    }
    
}

extension SignInViewController {
    
    private func setupViews() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
      
    }
    
    private func presentHomeViewController(with viewModel: HomeViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewVC")
        
        //(homeViewController as? HomeViewVC)?.viewModel = viewModel
        navigationController?.setViewControllers([homeViewController], animated: true)
    }
    
    func signInAction(){
        
        guard let phone = phoneTextfield.text, !phone.isEmpty,
                let password = passwordTextField.text, !password.isEmpty else {return}
        Task{
            do{
                try await viewModel?.signInButtonTapped(identifier: phone, password: password)
                if let homeViewModel = viewModel?.homeViewModel{
                    presentHomeViewController(with: homeViewModel)
                }
            }catch {
                self.showAlert(title: "Invalid Credentials", message: error.localizedDescription)
            }
        }
    }
}
