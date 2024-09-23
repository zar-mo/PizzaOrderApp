//
//  OrderViewController.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/22/24.
//

import UIKit

class OrderViewController: UIViewController {

    var viewModel: OrderViewModel?
    
   
    //@IBOutlet  var confirmButtons: [UIButton]!
    @IBOutlet weak var applePayTapped: UIButton!
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        setupUI()
        
        viewModel?.onUpdate = { [weak self] viewModel in
            self?.totalAmountLabel.text = viewModel.totalAmount
            //self?.confirmButtons.forEach { $0.isEnabled = viewModel.foodCount > 0 }
            DispatchQueue.main.async {
                //self?.reloadData(animated: true)
            }
        }
   
    }
    
    func setupUI(){
        totalValueLabel.text = viewModel?.totalAmount
    }

    @IBAction func applePayTapped(_ sender: UIButton) {
        
    }

    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ShowGratitudeMessage", sender: nil)
        viewModel?.confirmButtonTapped()
        
        
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

// MARK: - UITableViewDelegate

extension OrderViewController: UITableViewDelegate {
    
}
