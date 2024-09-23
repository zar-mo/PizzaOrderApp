//
//  ingredientsViewModel.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/22/24.
//

import Foundation

import UIKit

protocol IngredientsViewModel {
    var foodItem: FoodItem { get }
    var error: String? { get }
    var onUpdate: ((IngredientsViewModel) -> Void)? { get set }
    func addButtonTapped()
}

class IngredientsViewModelImpl: IngredientsViewModel {
   
    var error: String? {
        didSet { onUpdate?(self) }
    }
    var onUpdate: ((IngredientsViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    var foodItem: FoodItem
    private let ordersManager: OrdersManager?
    
    init(foodItem: FoodItem) {
        self.foodItem = foodItem
        self.ordersManager = UIApplication.shared.sceneDelegate?.ordersRepository
        

        
        
    }
    
    func addButtonTapped() {
        guard let count = ordersManager?.count(of: foodItem), count < 10 else { return }
        ordersManager?.add(foodItem)
    }
}

