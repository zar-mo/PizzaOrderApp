//
//  HomeViewModel.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/19/24.
//

import Foundation
import UIKit

protocol HomeViewModel {
    
    var cartAmount: String { get }
    var foodCount: Int { get }
    var onUpdate: ((HomeViewModel) -> Void)? { get set }
    func cellViewModel(at indexPath: IndexPath) -> HomeCellViewModel
    func menuViewModel(for indexPath: IndexPath) -> MenuViewModel
    func orderViewModel() -> OrderViewModel
    func signOut() async throws
    
}

class HomeViewModelImpl: HomeViewModel {
 
    var cartAmount: String { "\(ordersManager?.cartAmount ?? 0)"}
    
    var authService: AuthService
    
    
    private var foodGroups: [FoodGroup] = [] {
        didSet {onUpdate?(self)}
    }
    
    var foodCount: Int {
        foodGroups.count
    }
    
    var error: Error? {
        didSet { onUpdate?(self) }
    }
    
    
    var onUpdate: ((HomeViewModel) -> Void)? {
        didSet{
            onUpdate?(self)
        }
    }
    
    private var ordersManager: OrdersManager?
    
    init(authService: AuthService) {
        
        self.authService = authService
        
        DispatchQueue.main.async{
            self.ordersManager = UIApplication.shared.sceneDelegate?.ordersRepository
            self.ordersManager?.observe(self, selector: #selector(self.ordersListDidChange))
        }
        
        obtainData()
        
    }
    
    
    func cellViewModel(at indexPath: IndexPath) -> any HomeCellViewModel {
        HomeCellViewModelImpl(foodGroup: foodGroups[indexPath.row])
    }
    
    private func obtainData() {
        
        Task{
            
            let apiClient = APIClient(apiEndpoint: URL(string: Constants.foodBaseUrl.rawValue))
            let request = FoodRequest(path: Constants.foodPath.rawValue)
            do{
                foodGroups = try await apiClient.fetchData(request).foodGroups
                
            }catch {
                self.error = error
                print(error)
            }
        }
    }
    
    func menuViewModel(for indexPath: IndexPath) -> any MenuViewModel {
        return MenuViewModelImpl(foodGroup: foodGroups[indexPath.row])
    }
    
    func orderViewModel() -> any OrderViewModel {
        return OrderViewModelImpl()
    }
    
    func signOut() async throws {
        try await authService.signOut()
    }
    
    @objc private func ordersListDidChange() {
        onUpdate?(self)
    }
    
    
    
    
}
