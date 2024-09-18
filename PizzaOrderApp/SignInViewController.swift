//
//  SignInViewController.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/18/24.
//

import UIKit

class SignInViewController: UIViewController {


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
    


}
