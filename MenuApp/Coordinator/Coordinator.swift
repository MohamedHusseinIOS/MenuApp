//
//  Coordinator.swift
//  pagination-demo
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    
    static let shared = Coordinator()
    
    private var nvc: UINavigationController!
    private var childNVC: UINavigationController!
    
    var window: UIWindow?
    
    var mainNavigator: MainNavigator!
    
    var parentViewController: BaseViewController?
    
    private init(nvc: UINavigationController = UINavigationController()) {
        self.nvc = nvc
        self.mainNavigator = MainNavigator(navigationController: self.nvc)
    }
    
    func startApp( window: UIWindow?) {
        mainNavigator.navigate(To: .homeViewController)
        nvc.setNavigationBarHidden(false, animated: false)
        nvc.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        nvc.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        nvc.navigationBar.barTintColor = #colorLiteral(red: 0.8475798965, green: 0.3463075757, blue: 0.2594155669, alpha: 1)
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
        self.window = window
    }
}
