//
//  HomeCellViewModel.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/20/24.
//

import Foundation

protocol HomeCellViewModel {
    
    var foodGroup: FoodGroup! {get}

}

class HomeCellViewModelImpl: HomeCellViewModel {
    
    var foodGroup: FoodGroup!
    
    init(foodGroup: FoodGroup!) {
        self.foodGroup = foodGroup
    }
    
    
}
