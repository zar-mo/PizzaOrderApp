//
//  OrderCellViewModel.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/22/24.
//



import UIKit

protocol OrderCellViewModel {
    
    var orderItem: OrderItem {get}
    var error: String? { get }
    var onUpdate: ((OrderCellViewModel) -> Void)? { get set }
}

class OrderCellViewModelImpl: OrderCellViewModel {
    
    var orderItem: OrderItem
   
    var error: String? {
        didSet { onUpdate?(self) }
    }
    var onUpdate: ((OrderCellViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }
    
    
    init(orderItem: OrderItem) {
        self.orderItem = orderItem
      
    }
}

