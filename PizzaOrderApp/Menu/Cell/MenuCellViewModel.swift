//
//  MenuCellViewModel.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/21/24.
//

import Foundation

protocol FavoritesManager {
    func isFavorite(_ foodItem: FoodItem) -> Bool
    func add(_ foodItem: FoodItem)
    func remove(_ foodItem: FoodItem)
}

protocol OrdersManager {
    var cartAmount: Int { get }
    var orderItems: [OrderItem] { get }
    func add(_ foodItem: FoodItem)
    func remove(_ foodItem: FoodItem)
    func removeAll()
    func count(of foodItem: FoodItem) -> Int
    func observe(_ observer: Any, selector: Selector)
    
}

protocol MenuCellViewModel{
    
}

class MenuCellViewModelImpl : MenuCellViewModel {
    
    let foodItem: FoodItem
    
    init(foodItem: FoodItem) {
        self.foodItem = foodItem
    }
}
