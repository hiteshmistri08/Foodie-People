//
//  FoodItemViewModel.swift
//  Foodie People
//
//  Created by Hitesh on 04/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import Foundation

struct FoodItemViewModel {
    var itemName : String
    var category : String
    var categoryDisplayName : String
    var id : Int
    var imageName : String
    var price : String
    var itemDescription : String
    var isSelected = false
    
    
    init(_ model:FoodItem) {
        itemName = model.itemName
        category = model.category
        categoryDisplayName = model.categoryDisplayName
        id = model.id
        imageName = model.imageName
        price = "Price : " + model.price
        itemDescription = model.itemDescription
    }
}
