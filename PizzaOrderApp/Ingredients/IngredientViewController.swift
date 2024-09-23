//
//  IngredientViewController.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/22/24.
//

import UIKit

class IngredientViewController: UIViewController {
    
   
    @IBOutlet weak var addButtonLabel: UIButton!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    var viewModel: IngredientsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    
    }
    
    func setupUI(){
        
        guard let foodItem = viewModel?.foodItem else { return }
        
        titleLabel.text = foodItem.name.uppercased()
        addButtonLabel.setTitle("\(foodItem.price).00 ₴", for: .normal)
        ingredientsLabel.text = foodItem.description.components(separatedBy: ",")
                    .map { "• " + $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
                    .joined(separator: "\n")
        foodImageView.kf.setImage(with: URL(string: foodItem.imageUrl ?? ""))
    }
    
    @IBAction func addToCartButton(_ sender: UIButton) {
        
        viewModel?.addButtonTapped()
        dismiss(animated: true)
    }
    


}
