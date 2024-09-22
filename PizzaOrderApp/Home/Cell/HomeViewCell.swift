//
//  HomeViewCell.swift
//  PizzaOrderApp
//
//  Created by Abouzar Moradian on 9/20/24.
//

import UIKit
import Kingfisher
 

class HomeViewCell: UITableViewCell {

    var viewModel: HomeCellViewModel! {
        didSet { setupView()}
    }
    
    @IBOutlet weak var foodSubTitleLabel: UILabel!
    @IBOutlet weak var foodTitleLabel: UILabel!
    @IBOutlet weak var foodImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
    func setupView(){
        foodTitleLabel.text = viewModel.foodGroup.name
        foodSubTitleLabel.text = viewModel.foodGroup.description
        foodImageView.kf.setImage(with: URL(string: viewModel.foodGroup.imageUrl ?? ""))
        print(viewModel.foodGroup.imageUrl)

        
    }

}
