//
//  OrderViewCell.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/22/24.
//

import UIKit

class OrderViewCell: UITableViewCell {
    
    var viewModel: OrderCellViewModel? {
        didSet{ setupUI()}
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var detailPriceLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }
    
    func setupUI(){
        
        guard let orderItem = viewModel?.orderItem else {return}
        
        titleLabel.text = orderItem.foodItem.name
        subtitleLabel.text = orderItem.foodItem.description
        detailPriceLabel.text = "\(orderItem.qty) X \(orderItem.foodItem.price) ₴"
        totalPriceLabel.text = "\(orderItem.qty * orderItem.foodItem.price).00 ₴"
        cellImageView.kf.setImage(with: URL(string: orderItem.foodItem.imageUrl ?? ""))
        
        
    }

}
