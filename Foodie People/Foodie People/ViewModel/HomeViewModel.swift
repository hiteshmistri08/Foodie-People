//
//  HomeViewModel.swift
//  Foodie People
//
//  Created by Hitesh on 04/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import Foundation

struct HomeViewModel {
    var bannerImageCollectionViewCellViewModels = [BannerImageCollectionViewCellViewModel]()
    private var foodItemViewModels = [FoodItemViewModel]()
    var foodCategorySections = [FoodCategorySectionViewModel]()
    private var categoryItem = [String]()
    
    init() {
        if let foodItems = loadJson(filename: "foodData") {
            //Set category name
            categoryItem =  Array(Set(foodItems.map({$0.categoryDisplayName}))).sorted()
            foodItemViewModels = foodItems.map({FoodItemViewModel($0)})
            for item in categoryItem {
                //Filter item according to category name and map to viewModel
                let filterItem = foodItemViewModels.filter({$0.categoryDisplayName == item})
                foodCategorySections.append(FoodCategorySectionViewModel(categoryName: item, foodItemsViewModels: filterItem))
            }
        }
        //Set banner images to viewModel
        for imageName in ["banner1","banner2","banner3","banner4","banner5"] {
            bannerImageCollectionViewCellViewModels.append(BannerImageCollectionViewCellViewModel(imageName: imageName))
        }
    }
    
    //Load Json data from file
    private func loadJson(filename fileName: String) -> [FoodItem]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.foodItems
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    //Upadate food item selection in model
    mutating func updateFoodItemModel(at section:Int, itemId id:Int, item isSelected:Bool) {
        //Find the index where this category id exist and update the isSelected flag
        if let index = foodCategorySections[section].foodItemsViewModels.firstIndex(where: {$0.id == id}) {
            foodCategorySections[section].foodItemsViewModels[index].isSelected = isSelected
        }
    }
}
