//
//  ItemsViewController.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import UIKit

class ItemsViewController: BaseViewController {

    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    
    let viewModel = ItemsViewModel()
    
    var tag: Tag?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = tag?.tagName
        viewModel.getItems(byTag: tag?.tagName ?? "")
    }
    
    override func configureData() {}
    
    override func configureUI() {
        RegisterNibs()
        setFlowlayout()
        loaditemsCollectionView()
        didSelectCell()
        
        viewModel.output.faliure.bind { (error) in
            self.alert(title: "", message: error.first?.message, completion: nil)
        }.disposed(by: viewModel.bag)
    }
    
    func RegisterNibs() {
        let nib = UINib(nibName: TagCell.id, bundle: .main)
        itemsCollectionView.register(nib, forCellWithReuseIdentifier: TagCell.id)
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
        flow.minimumLineSpacing = 0
        itemsCollectionView?.collectionViewLayout = flow
    }
    
    func loaditemsCollectionView() {
        viewModel.output
            .items
            .bind(to: itemsCollectionView.rx.items) { tableView, row, element in
                let index = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(withReuseIdentifier: TagCell.id, for: index) as? TagCell  else { return TagCell() }
                cell.bindOn(item: element)
                return cell
            }.disposed(by: viewModel.bag)
    }
    
    func didSelectCell() {
        itemsCollectionView.rx
            .itemSelected
            .bind { [unowned self] (indexPath) in
                let item = self.viewModel.itemsArray[indexPath.row]
                guard let vc = Coordinator.shared.mainNavigator.makeViewController(for: .itemDetailsViewController(item)) else { return }
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
        }.disposed(by: viewModel.bag)
    }
    
    func scroll() {
        
    }

}
