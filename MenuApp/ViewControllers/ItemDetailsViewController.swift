//
//  ItemDetailsViewController.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import UIKit
import Hero
import RxSwift

class ItemDetailsViewController: BaseViewController {

    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemDescriptionLbl: UILabel!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    var item = Item()
    let viewModel = ItemDetailsViewModel()
    
    let itemImgMaxHeight: CGFloat = 300
    let itemImgMinHeight: CGFloat = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(panGesture)
        
        titleLbl.text = item.name
        itemImg.hero.id = item.name
        let url = URL(string: item.photoUrl ?? "")
        itemImg.kf.setImage(with: url)
        itemNameLbl.text = item.name
        itemDescriptionLbl.text = item.description
    }
    
    override func configureData() {}
    
    override func configureUI() {
        scrollViewConfigration()
        handlePan()
        backBtn.rx.tap.bind { () in
            Hero.shared.animate()
            self.hero.dismissViewController()
        }.disposed(by: viewModel.bag)
    }
    
    func scrollViewConfigration() {
        scrollView.rx
            .didScroll
            .observeOn(MainScheduler.asyncInstance)
            .bind {[unowned self] () in
                let y = self.scrollView.contentOffset.y
                let itemImgNewHeight = self.headerHeightConstraint.constant - y
                
                if itemImgNewHeight > self.itemImgMaxHeight {
                    self.headerHeightConstraint.constant = self.itemImgMaxHeight
                    self.itemImg.isHidden = false
                } else if itemImgNewHeight < self.itemImgMinHeight {
                    self.headerHeightConstraint.constant = self.itemImgMinHeight
                    self.itemImg.isHidden = true
                } else {
                    self.headerHeightConstraint.constant = itemImgNewHeight
                    self.itemImg.isHidden = false
                    self.scrollView.contentOffset.y = 0
                }
            }.disposed(by: viewModel.bag)
    }
    
    func handlePan() {
        panGesture.rx
            .event
            .observeOn(MainScheduler.asyncInstance)
            .bind { [unowned self] (sender) in
                let translation = sender.translation(in: nil)
                let progress = translation.y / 2 / self.view.bounds.height
                switch sender.state {
                case .began:
                    // Start the dismiss of View Controller on Pan
                    self.hero.dismissViewController()
                case .changed:
                    // Update pan progress
                    Hero.shared.update(progress)

                    // Add additional animations with modifiers
                    let currentPos = CGPoint(x: translation.x + self.headerView.center.x, y: translation.y + self.headerView.center.y)
                    Hero.shared.apply(modifiers: [.position(currentPos)], to: self.headerView)
                default:
                    // Cancel or finish transition
                    if progress + sender.velocity(in: nil).y / self.view.bounds.height > 0.2 {
                        Hero.shared.finish()
                    } else {
                        Hero.shared.cancel()
                    }
                }
            }.disposed(by: viewModel.bag)
    }
    
}
