//
//  FoodItemTableViewCell.swift
//  Foodie People
//
//  Created by Hitesh on 04/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

final class FoodItemTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlet
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var itemTitle: UILabel!
    @IBOutlet private weak var itemPrice: UILabel!
    @IBOutlet private weak var itemDetail: UILabel!
    
    //MARK:- Property
    static let reuseIdentifier: String = "FoodItemTableViewCell"

    static var nib: UINib {
        return UINib(nibName: "FoodItemTableViewCell", bundle: nil)
    }
    
    //MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        renderContainerView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Member functions
    private func renderContainerView() {
        containerView.layer.cornerRadius = 8.0
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        containerView.layer.shadowRadius = 3.0
        containerView.layer.shadowOpacity = 1.0
    }
    func configureCell(_ viewModel:FoodItemViewModel) {
        imgView.image = UIImage(named: viewModel.imageName)
        itemTitle.text = viewModel.itemName
        itemPrice.text = viewModel.price
        itemDetail.text = viewModel.itemDescription
        containerView.backgroundColor = viewModel.isSelected ? UIColor.link.withAlphaComponent(0.5) : UIColor.white
    }
}
