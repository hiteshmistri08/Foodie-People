//
//  HomeViewController.swift
//  Foodie People
//
//  Created by Hitesh on 04/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    //MARK:- IBOutlet
    @IBOutlet private weak var tableView:UITableView!

    //MARK:- Property
    private var viewModel = HomeViewModel()
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI() {
        self.title = "Foodie People"
        configureTableView()
    }
    private func configureTableView() {
        //Regiister Banner header view
        tableView.register(BannerTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: BannerTableViewHeaderFooterView.reuseIdentifier)
        
        //Register Food Item tableviewCell
        tableView.register(FoodItemTableViewCell.nib, forCellReuseIdentifier: FoodItemTableViewCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func indexPathsForSection(section:Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        
        for row in 0..<self.viewModel.foodCategorySections[section].foodItemsViewModels.count {
            indexPaths.append(IndexPath(row: row,
                                        section: section))
        }
        
        return indexPaths
    }
    @objc func hideSection(sender:UIButton) {
        let section = sender.tag
        let categorySection = self.viewModel.foodCategorySections[section]
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            //section increase by 1, because first for banner image
            let updateSection = section + 1
            for row in 0..<categorySection.foodItemsViewModels.count {
                indexPaths.append(IndexPath(row: row,
                                            section: updateSection))
            }
            return indexPaths
        }
        
        if categorySection.isCollapsed {
            self.viewModel.foodCategorySections[section].isCollapsed = false
            self.tableView.insertRows(at: indexPathsForSection(),
                                      with: .fade)
        } else {
            self.viewModel.foodCategorySections[section].isCollapsed = true
            self.tableView.deleteRows(at: indexPathsForSection(),
                                      with: .fade)
        }
    }
    //MARK:- Navigation
    private func navigateToItemDetailScreen(_ section:Int, _ foodViewModel:FoodItemViewModel) {
        let vc = self.storyboard?.instantiateViewController(identifier: ItemDetailViewController.identifier) as! ItemDetailViewController
        //Set Food item data to detail view Controller
        vc.setFoodItemData(foodViewModel)
        vc.handlerItemSelected = { [weak self] (isSelected, itemId) in
            self?.viewModel.updateFoodItemModel(at: section, itemId: itemId, item: isSelected)
            self?.tableView.reloadData()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- UITableViewDataSource
extension HomeViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + viewModel.foodCategorySections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            //Check section is collapsed or not
            let foodCategory = self.viewModel.foodCategorySections[section - 1]
            return foodCategory.isCollapsed ? 0 : foodCategory.foodItemsViewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodItemTableViewCell.reuseIdentifier) as! FoodItemTableViewCell
        cell.configureCell(viewModel.foodCategorySections[indexPath.section - 1].foodItemsViewModels[indexPath.row])
        return cell
    }
    
    
}
//MARK:- UITableViewDelegate
extension HomeViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: BannerTableViewHeaderFooterView.reuseIdentifier) as? BannerTableViewHeaderFooterView else { return nil }
            view.configureView(viewModel.bannerImageCollectionViewCellViewModels)
            return view
        } else {
            let title = viewModel.foodCategorySections[section - 1].categoryName
            let sectionButton = UIButton()
            sectionButton.setTitle(String(title),
                                   for: .normal)
            sectionButton.backgroundColor = .lightGray
            sectionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            sectionButton.setTitleColor(.black, for: .normal)
            sectionButton.tag = section - 1
            sectionButton.addTarget(self,
                                    action: #selector(self.hideSection(sender:)),
                                    for: .touchUpInside)
            return sectionButton
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //Set height for first header 
        return section == 0 ? 200.0 : 44.0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToItemDetailScreen(indexPath.section - 1, viewModel.foodCategorySections[indexPath.section - 1].foodItemsViewModels[indexPath.row])
    }
    
}
