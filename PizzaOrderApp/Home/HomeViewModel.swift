//
//  HomeViewModel.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/19/24.
//

import Foundation

protocol HomeViewModel {
    
    
    var onUpdate: ((HomeViewModel) -> Void)? {get set}
    func cellViewModel(at indexPath: IndexPath) -> HomeCellViewModel
    
}

class HomeViewModelImpl: HomeViewModel {
    
    private var foodGroups: [FoodGroup] = [] {
        didSet {onUpdate?(self)}
    }
    
    var error: Error? {
        didSet { onUpdate?(self) }
    }
    
    
    var onUpdate: ((HomeViewModel) -> Void)? {
        didSet{
            onUpdate?(self)
        }
    }

    
    func cellViewModel(at indexPath: IndexPath) -> any HomeCellViewModel {
        HomeCellViewModelImpl(foodGroup: foodGroups[indexPath.row])
    }
    
    private func obtainData() async throws{
        
        let apiClient = APIClient(apiEndpoint: URL(string: Constants.foodBaseUrl.rawValue))
        let request = FoodRequest(path: Constants.foodPath.rawValue)
        do{
            foodGroups = try await apiClient.fetchData(request)
        }catch {
            self.error = error
        }
    }
    
    
    
}
