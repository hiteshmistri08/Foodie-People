//
//  BannerImageCollectionViewCell.swift
//  Foodie People
//
//  Created by Hitesh on 04/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

final class BannerImageCollectionViewCell: UICollectionViewCell {
    
    //MARKL:- IBOutlet
    @IBOutlet private weak var imageView:UIImageView!
    
    //MARK:- Property
    static let reuseIdentifier: String = "BannerImageCollectionViewCell"

    static var nib: UINib {
        return UINib(nibName: "BannerImageCollectionViewCell", bundle: nil)
    }

    //MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(_ viewModel:BannerImageCollectionViewCellViewModel) {
        imageView.image = UIImage(named: viewModel.imageName)
    }
}
