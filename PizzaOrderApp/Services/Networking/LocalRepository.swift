//
//  LocalRepository.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/21/24.
//

import Foundation

protocol LocalRepository: AnyObject {
    associatedtype Model
    var items: [Model] {get set}
    func add(_ item: Model)
    func remove(_ item: Model)
    func fetch()
    func save()
}

extension LocalRepository where Model : Codable & Identifiable{
    
    func add(_ item: Model){
        items.append(item)
    }
    
    func remove(_ item: Model) {
        items.removeAll(where: {$0.id == item.id})
    }
    
    private var defaults: UserDefaults {UserDefaults.standard}
    private var key: String {String(reflecting: Self.self) + String(reflecting: Self.Model.self)}
    
    func fetch() {
        let data = defaults.array(forKey: key) as? [Data] ?? []
        items = data.compactMap { try? JSONDecoder().decode(Model.self, from: $0)}
    }
    
    func save() {
        
        let data = items.compactMap { try? JSONEncoder().encode($0)}
        defaults.setValue(data, forKey: key)
    }
    
}

// MARK: Favorites Repository

class FavoritesRepository: LocalRepository, FavoritesManager  {
    
    var items: [FoodItem] = []
    
    func isFavorite(_ foodItem: FoodItem) -> Bool {
        items.contains(where: {foodItem.id == $0.id})
    }
   
}

// MARK: Order Repository

class OrdersRepository: LocalRepository, OrdersManager {
    
    
    var items: [FoodItem] = [] {
        didSet { 
            
            notify() }
    }
    
    var orderItems: [OrderItem]  {
        var orderItems: [OrderItem] = []
        for item in items {
            if var index = orderItems.firstIndex(where: {$0.foodItem.id == item.id }){
                orderItems[index].qty += 1
            }else {
                orderItems.append(OrderItem(foodItem: item, qty: 1))
            }
        }
        return orderItems
    }
    
    var cartAmount: Int { items.reduce(0){ 0 + $1.price}}
    
    func remove(_ foodItem: FoodItem) {
        guard let index = items.firstIndex(where: { $0.id == foodItem.id }) else { return }
        items.remove(at: index)
    }
    
    func removeAll() {
        items = []
    }
    
    func count(of foodItem: FoodItem) -> Int {
        items.filter { $0.id == foodItem.id }.count
    }
    
    func observe(_ observer: Any, selector: Selector) {
        
        NotificationCenter.default.addObserver(observer, selector: selector, name: .orderListDidChange, object: nil)
    }
    
    private func notify() {
        NotificationCenter.default.post(name: .orderListDidChange, object: nil)
    }
    
    
}

private extension NSNotification.Name {
    static let orderListDidChange = NSNotification.Name("orderListDidChange")
}


