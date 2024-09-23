//
//  OrderViewController.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/22/24.
//

import UIKit

class OrderViewController: UIViewController {

    var viewModel: OrderViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
   
    }

}

// MARK: - UITableViewDataSource

extension OrderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.foodCount ?? 5
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
        cell.viewModel = viewModel?.cellViewModel(at: indexPath)
        return cell
    }
}
