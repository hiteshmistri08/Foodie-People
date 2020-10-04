//
//  FoodItem.swift
//  Foodie People
//
//  Created by Hitesh on 04/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import Foundation

struct FoodItem : Decodable {
    var itemName : String
    var category : String
    var categoryDisplayName : String
    var id : Int
    var imageName : String
    var price : String
    var itemDescription : String
}

struct ResponseData: Decodable {
    var foodItems: [FoodItem]
}
