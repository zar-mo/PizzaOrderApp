//
//  MenuViewController.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/22/24.
//

import UIKit

class MenuViewController: UIViewController {
 
    var viewModel: MenuViewModel?

    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        viewModel?.onUpdate = {[weak self] viewModel in
            DispatchQueue.main.async{
                self?.tableView.reloadData()
            }
        }
   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowOrder" {
            if let orderViewController = segue.destination as? OrderViewController {
                orderViewController.viewModel = viewModel?.orderViewModel()
            }
        }
       
    }

}

// MARK: - UITableViewDataSource methods
extension  MenuViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.foodCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuViewCell else{ return UITableViewCell()}
        cell.viewModel = viewModel?.menuCellViewModel(at: indexPath)
        return cell
    }
    
}

// MARK: - UITableViewDelegate method

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //performSegue(withIdentifier: "ShowIngredients", sender: indexPath)
    }
}
