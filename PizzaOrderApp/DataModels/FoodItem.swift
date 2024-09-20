//
//  FoodItem.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/20/24.
//

import Foundation

struct FoodItem: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let weight: Int
    let price: Int
    let imageURL: URL?
}

