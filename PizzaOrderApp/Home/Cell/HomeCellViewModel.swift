//
//  HomeCellViewModel.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/20/24.
//

import Foundation

protocol HomeCellViewModel {
    
    
    var foodGroup: FoodGroup! {get}
    var onUpdate: ((HomeCellViewModel) -> Void)? { get set }

}

class HomeCellViewModelImpl: HomeCellViewModel {
    
    var onUpdate: ((HomeCellViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    
    var foodGroup: FoodGroup! {
        didSet { onUpdate?(self) }
    }
    
    
    init(foodGroup: FoodGroup!) {
        self.foodGroup = foodGroup
    }
    
    
}
