//
//  ServerPaths.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation

enum ServerPaths: String {
    case tags = "tags/"
    case items = "items/"
    
     func page(_ page: Int) -> String {
        return self.rawValue + "\(page)"
    }
    
    func tag(_ tag: String) -> String {
        return self.rawValue + "\(tag)"
    }
}
