//
//  mainNavoigator.swift
//  pagination-demo
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import UIKit

//MARK:- storyboards
enum storyboards: String {
    case main = "Main"
    
    var instanse: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: .main)
    }
}

class MainNavigator{
    
    private var navigationController: UINavigationController!
    let presentNVC = UINavigationController()
    var currentVC: Destination?
    var lastVC: UIViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

extension MainNavigator: Navigator{
    //MARK:- Destination
    enum Destination {
        
        //Main Storyboard
        case homeViewController
        case itemsViewController(_ tag: Tag)
        case itemDetailsViewController(_ item: Item)
    }
    
    func navigate(To destination: Destination) {
        guard let vc = makeViewController(for: destination) else{ return }
        currentVC = destination
        lastVC = vc
        navigationController.pushViewController(vc, animated: true)
    }
    
    func present(_ destination: Destination, completion: (() -> Void)?) {
        guard let vc = makeViewController(for: destination) else { return }
        presentNVC.viewControllers.append(vc)
        //vc.modalPresentationStyle = .overCurrentContext
        //vc.modalTransitionStyle = .partialCurl
        navigationController.viewControllers.last?.present(vc, animated: true, completion: completion)
    }
    
    func popViewController(to destination: Destination?){
        currentVC = destination
        navigationController.popViewController(animated: true)
        lastVC = navigationController.viewControllers.last
    }
    
    func makeViewController(for destination: Destination)-> UIViewController? {
        switch destination {
        //MARK:- home
        case .homeViewController, .itemsViewController, .itemDetailsViewController:
            return homeViewControllers(by: destination)
        }
    }
    
    
    
    func homeViewControllers(by destination: Destination) -> UIViewController? {
        switch destination {
        case .homeViewController:
            let vc = HomeViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: HomeViewController())
            return vc
        case .itemsViewController(let tag):
            guard let vc = ItemsViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: ItemsViewController()) else { return ItemsViewController() }
            vc.tag = tag
            return vc
        case .itemDetailsViewController(let item):
            guard let vc = ItemDetailsViewController.InstantiateFormStoryBoard(storyboards.main.instanse, vc: ItemDetailsViewController()) else { return ItemDetailsViewController() }
            vc.item = item
            return vc
        }
    }
    
}
