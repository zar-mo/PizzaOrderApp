//
//  MenuViewCell.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/22/24.
//

import UIKit
import Kingfisher

class MenuViewCell: UITableViewCell {

    @IBOutlet weak var addButtonLabel: UIButton!
    @IBOutlet weak var favoriteLabel: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    var viewModel: MenuCellViewModel? {
        didSet { setupView()}
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func favorites(_ sender: UIButton) {
        
        viewModel?.favoriteButtonTapped()
    }
    @IBAction func addButton(_ sender: UIButton) {
        
        viewModel?.addButtonTapped()
    }
    func setupView() {
        
        guard var viewModel = viewModel else { return }
        titleLabel.text = viewModel.foodItem.name
        subtitleLabel.text = viewModel.foodItem.description
        priceLabel.text = "\(viewModel.foodItem.price).00 ₴"
        weightLabel.text = "\(viewModel.foodItem.weight) g"
        cellImageView.kf.setImage(with: URL(string: viewModel.foodItem.imageUrl ?? ""))
        
        viewModel.onUpdate = {[weak self ] viewModel in
            
            self?.favoriteLabel.setImage(UIImage(systemName: viewModel.isFavorite ? "star.fill" : "star"), for: .normal)
            
            let addImage = viewModel.orderedQty > 0
                ? UIImage(systemName: "\(viewModel.orderedQty).circle.fill")
                : UIImage(systemName: "cart.badge.plus")
            self?.addButtonLabel.setImage(addImage, for: .normal)
            
        }
      
    }

}
