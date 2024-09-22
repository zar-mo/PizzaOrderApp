//
//  ingredientsViewModel.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/22/24.
//

import Foundation

protocol IngredientsViewModel{
    
    
}

class IngredientsViewModelImpl: IngredientsViewModel {
    
    let foodItem: FoodItem
    
    init(foodItem: FoodItem) {
        self.foodItem = foodItem
    }
}
