//
//  ItemDetailViewController.swift
//  Foodie People
//
//  Created by Hitesh on 04/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

final class ItemDetailViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet private weak var itemImageView:UIImageView!
    @IBOutlet private weak var itemNameLabel:UILabel!
    @IBOutlet private weak var itemPriceLabel:UILabel!
    @IBOutlet private weak var itemDescriptionLabel:UILabel!
    @IBOutlet private weak var itemSelecteButton:UIButton!
    
    //MARK:- Property
    static let identifier = "ItemDetailViewController"
    
    private var viewModel: FoodItemViewModel!
    var handlerItemSelected:(Bool,Int) -> Void = {_,_ in} // isSelected, Item Id

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        self.title = viewModel.categoryDisplayName
        renderSelectedButton()
        renderUI()
    }
    private func renderUI() {
        //Render UI
        itemImageView.image = UIImage(named: viewModel.imageName)
        itemNameLabel.text = viewModel.itemName
        itemPriceLabel.text = viewModel.price
        itemNameLabel.text = viewModel.itemName
        itemDescriptionLabel.text = viewModel.itemDescription

        itemSelecteButton.setTitle(viewModel.isSelected ? "Selected": "Select", for: .normal)
        itemSelecteButton.setTitleColor(viewModel.isSelected ? .white : .link, for: .normal)
        itemSelecteButton.backgroundColor = viewModel.isSelected ? .link : .white
    }
    //Set ViewModel data
    func setFoodItemData(_ viewModel:FoodItemViewModel) {
        self.viewModel = viewModel
    }
    
    private func renderSelectedButton() {
        itemSelecteButton.layer.cornerRadius = 8
        itemSelecteButton.layer.borderWidth = 1.0
        itemSelecteButton.layer.borderColor = UIColor.link.cgColor
    }
    
    //MARK:- IBAction
    @IBAction private func onBtnSelectAction(_ sender:UIButton) {
        handlerItemSelected(!viewModel.isSelected, viewModel.id)
        self.navigationController?.popViewController(animated: true)
    }
}
