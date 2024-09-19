//
//  SignInViewController.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/18/24.
//

import UIKit

class SignInViewController: UIViewController {


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
    }
    

}
