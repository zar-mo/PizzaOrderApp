//
//  FoodGroup.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/20/24.
//

import Foundation

struct FoodGroup: Codable {
    let id: Int
    let name: String
    let description: String
    let imageUrl: String?
    let foodItems: [FoodItem]
}
