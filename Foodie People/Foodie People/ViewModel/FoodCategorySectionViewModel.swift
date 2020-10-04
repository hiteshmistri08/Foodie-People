//
//  FoodCategorySectionViewModel.swift
//  Foodie People
//
//  Created by Hitesh on 04/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import Foundation

struct FoodCategorySectionViewModel {
    var categoryName:String
    var foodItemsViewModels:[FoodItemViewModel]
    var isCollapsed : Bool = false
}
