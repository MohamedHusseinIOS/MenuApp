//
//  BaseViewController.swift
//  pagination-demo
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, Instantiator {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureUI()
        // Do any additional setup after loading the view.
    }

    func configureData(){}
    
    func configureUI(){}
    
}
