//
//  MenuViewModel.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/21/24.
//

import UIKit

protocol MenuViewModel {
    
    var cartAmount: String {get}
    var foodCount: Int {get}
    var onUpdate : ((MenuViewModel) -> Void)? {set get}
    func orderViewModel() -> OrderViewModel
    func menuCellViewModel(at indexPath: IndexPath) -> MenuCellViewModel
    func ingredientViewModel(at indexPath: IndexPath) -> IngredientsViewModel
    
    
}

class MenuViewModelImpl : MenuViewModel {
    
    let foodGroup: FoodGroup
    
    
    var title: String {foodGroup.name}
    var cartAmount: String {  "\(ordersManager?.cartAmount ?? 0)" }
    var foodCount: Int { foodGroup.foodItems.count }
    
    var ordersManager: OrdersManager?
    
    
    var onUpdate: ((MenuViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    init(foodGroup: FoodGroup){
        
        self.foodGroup = foodGroup
        self.ordersManager = UIApplication.shared.sceneDelegate?.ordersRepository
        self.ordersManager?.observe(self, selector: #selector(ordersListDidChange))
        
    }
    
    func orderViewModel() -> any OrderViewModel {
        OrderViewModelImpl()
    }
    
    func menuCellViewModel(at indexPath: IndexPath) -> any MenuCellViewModel {
        MenuCellViewModelImpl(foodItem: foodGroup.foodItems[indexPath.row])
    }
    
    func ingredientViewModel(at indexPath: IndexPath) -> any IngredientsViewModel {
        IngredientsViewModelImpl(foodItem: foodGroup.foodItems[indexPath.row])
    }
    
    @objc func ordersListDidChange(){
        onUpdate?(self)
    }
    
    
}
