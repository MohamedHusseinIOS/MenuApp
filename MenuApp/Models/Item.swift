//
//  Item.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation

struct ItemResponse: BaseModel {
    var items: Array<Item>?
}

struct Item: BaseModel {
    var id: Int?
    var name: String?
    var photoUrl: String?
    var description: String?
}

extension Item: Equatable {
    
}
