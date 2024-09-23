//
//  HomeViewVC.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/19/24.
//

import UIKit

class HomeViewVC: UIViewController {
    
    var viewModel: HomeViewModel?
        

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel?.onUpdate = { [weak self] viewModel in
            
            print("food loaded")
            DispatchQueue.main.async {
                
                self?.tableView.reloadData()
            }
            
        }
  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowOrder" {
            let orderViewController = segue.destination as? OrderViewController
            //orderViewController?.viewModel = viewModel.orderViewModel()
          
        }else if let indexPath = sender as? IndexPath, segue.identifier == "ShowMenu" {
            let menuViewController = segue.destination as? MenuViewController
            menuViewController?.viewModel = viewModel?.menuViewModel(for: indexPath)
        }
    }


}

// MARK: - UITableViewDataSource

extension HomeViewVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.foodCount ?? 0
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        cell.viewModel = viewModel?.cellViewModel(at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension HomeViewVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowMenu", sender: indexPath)
        
        
    }
}
