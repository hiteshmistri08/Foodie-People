//
//  BannerTableViewHeaderFooterView.swift
//  Foodie People
//
//  Created by Hitesh on 04/10/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

final class BannerTableViewHeaderFooterView: UITableViewHeaderFooterView {

    //MARK:- Property
    static let reuseIdentifier: String = "BannerTableViewHeaderFooterView"

    static var nib: UINib {
        return UINib(nibName: "BannerTableViewHeaderFooterView", bundle: nil)
    }
    private var bannerImageCollectionViewCellViewModels = [BannerImageCollectionViewCellViewModel]()
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let pageControll = UIPageControl(frame: .zero)

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    private func configureContents() {
        contentView.backgroundColor = UIColor.white
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControll)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            pageControll.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0.0),
            pageControll.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Members function
    private func configureCollectionView() {
        //register CollectionView Cell
        collectionView.register(BannerImageCollectionViewCell.nib, forCellWithReuseIdentifier: BannerImageCollectionViewCell.reuseIdentifier)
        collectionView.isPagingEnabled = true
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    private func configurePageControll() {
        pageControll.currentPageIndicatorTintColor = .link
        pageControll.pageIndicatorTintColor = .white
        pageControll.numberOfPages = bannerImageCollectionViewCellViewModels.count
        pageControll.currentPage = 0
        pageControll.hidesForSinglePage = true
    }
    func configureView(_ viewModels:[BannerImageCollectionViewCellViewModel]) {
        self.bannerImageCollectionViewCellViewModels = viewModels
        configureCollectionView()
        configurePageControll()
    }
    
}

//MARK:- UICollectionViewDataSource
extension BannerTableViewHeaderFooterView:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImageCollectionViewCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerImageCollectionViewCell.reuseIdentifier, for: indexPath) as! BannerImageCollectionViewCell
        cell.configureCell(bannerImageCollectionViewCellViewModels[indexPath.row])
        return cell
    }
}
//MARK:- UICollectionViewDelegate
extension BannerTableViewHeaderFooterView:UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
       let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
       if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
                self.pageControll.currentPage = visibleIndexPath.row
       }
    }
}
//MARK:- UICollectionViewFlowLayout
extension BannerTableViewHeaderFooterView:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.contentView.bounds.size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
