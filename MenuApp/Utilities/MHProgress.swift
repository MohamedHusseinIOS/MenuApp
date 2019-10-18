//
//  MHProgress.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 19/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import UIKit

class MHProgress: UIView {
    
    private let indecator = UIActivityIndicatorView()
    private let containerView = UIVisualEffectView()
    
    static let sharedMHP = MHProgress()
    
    private init() {
        let size = UIScreen.main.bounds.size
        let origin = CGPoint(x: 0, y: 0)
        let rect = CGRect(origin: origin, size: size)
        super.init(frame: rect)
        configureContainer()
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureContainer() {
        self.backgroundColor = UIColor.clear
        containerView.cornerRadius = 10
        containerView.clipToBounds = true
        containerView.layer.opacity = 1
        containerView.effect = UIBlurEffect(style: .light)
        containerView.frame.size = CGSize(width: 100, height: 100)
        containerView.frame.origin = CGPoint(x: (UIScreen.main.bounds.width/2 - containerView.frame.width/2),
                                             y: (UIScreen.main.bounds.height/2 - containerView.frame.height/2))
        
        indecator.frame.size = CGSize(width: 50, height: 50)
        indecator.frame.origin = CGPoint(x: (containerView.frame.width/2) - (indecator.frame.width/2) ,
                                         y: (containerView.frame.height/2) - (indecator.frame.height/2))
        indecator.tintColor = UIColor.darkGray
        indecator.color = UIColor.black
        containerView.contentView.addSubview(indecator)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
    }
    
    func show() {
        indecator.startAnimating()
        Coordinator.shared.window?.addSubview(self)
    }
    
    func hide() {
        indecator.stopAnimating()
        self.removeFromSuperview()
    }
}
