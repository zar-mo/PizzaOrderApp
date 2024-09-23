//
//  MenuCellViewModel.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/21/24.
//

import UIKit


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
    var foodItem: FoodItem {get set}
    var isFavorite: Bool { get }
    var orderedQty: Int { get }
    var error: String? { get }
    var onUpdate: ((MenuCellViewModel) -> Void)? { get set }
    func favoriteButtonTapped()
    func addButtonTapped()
    
}

class MenuCellViewModelImpl : MenuCellViewModel {
    
    
    var foodItem: FoodItem
    
    var isFavorite: Bool {  favoritesManager?.isFavorite(foodItem) ?? false }
    
    var orderedQty: Int { ordersManager?.count(of: foodItem) ?? 0}
    
    var error: String? {
        didSet { onUpdate?(self) }
    }
    
    var onUpdate: ((any MenuCellViewModel) -> Void)? {
        didSet { onUpdate?(self)}
    }
    
    var ordersManager: OrdersManager?
    var favoritesManager: FavoritesManager?
    
    init(foodItem: FoodItem) {
        self.foodItem = foodItem
        
        self.ordersManager = UIApplication.shared.sceneDelegate?.ordersRepository
        self.ordersManager?.observe(self, selector: #selector(ordersListDidChange))
        
        self.favoritesManager = UIApplication.shared.sceneDelegate?.favoritesRepository

    }
    
    func favoriteButtonTapped() {
        
        !isFavorite ? favoritesManager?.add(foodItem)
                    : favoritesManager?.remove(foodItem)
        onUpdate?(self)
    }
    
    func addButtonTapped() {
        
        guard let count = ordersManager?.count(of: foodItem), count < 10 else { return }
        ordersManager?.add(foodItem)
    }
    
    @objc private func ordersListDidChange() {
        onUpdate?(self)
    }
    
}
