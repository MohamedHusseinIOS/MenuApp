//
//  HomeViewController.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {

    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    let viewModel = HomeViewModel()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tags"
        viewModel.getTags(byPage: page)
    }
    
    override func configureData() {}
    
    override func configureUI() {
        registerCell()
        setFlowlayout()
        loadTagsCollectionView()
        cellWillDisplay()
        didSelectCell()
        
        viewModel.output
            .faliure
            .bind { (error) in
                self.alert(title: "", message: error.first?.message, completion: nil)
            }.disposed(by: viewModel.bag)
    }
    
    func registerCell() {
        let nib = UINib(nibName: TagCell.id, bundle: .main)
        tagsCollectionView.register(nib, forCellWithReuseIdentifier: TagCell.id)
    }
    
    func setFlowlayout() {
        let flow = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width / 1.7)
        
        let cellCount = 3
        let cellMerginSize = 10
        let mergin = cellMerginSize * 2
        
        let height = ((view.frame.height - 70) - CGFloat(mergin) * CGFloat(cellCount) - CGFloat(mergin)) / CGFloat(cellCount)
        
        flow.scrollDirection = .horizontal
        flow.itemSize = CGSize(width: width, height: height)
        flow.minimumInteritemSpacing = 10
        flow.minimumLineSpacing = 10
        tagsCollectionView?.collectionViewLayout = flow
    }
    
    func loadTagsCollectionView() {
        viewModel
            .output
            .tags
            .bind(to: tagsCollectionView.rx.items) { (collectionView, row, element) in
                let index = IndexPath(row: row, section: 0)
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.id, for: index) as? TagCell else { return TagCell()}
                cell.bindOn(tag: element)
                return cell
            }.disposed(by: viewModel.bag)
    }
    
    func cellWillDisplay() {
        tagsCollectionView.rx
            .willDisplayCell
            .bind { [unowned self] (cell, indexPath) in
                guard (self.viewModel.tagsArray.count - 1) == indexPath.item  else { return }
                self.page += 1
                self.viewModel.getTags(byPage: self.page)
            }.disposed(by: viewModel.bag)
    }
    
    func didSelectCell() {
        tagsCollectionView.rx
            .itemSelected
            .bind { [unowned self] (indexPath) in
                let tag = self.viewModel.tagsArray[indexPath.row]
                Coordinator.shared.mainNavigator.navigate(To: .itemsViewController(tag))
            }.disposed(by: viewModel.bag)
    }
    
}
