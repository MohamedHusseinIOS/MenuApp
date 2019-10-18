//
//  Tag.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation

struct TagsResponse: BaseModel {
    var tags: Array<Tag>?
}

struct Tag: BaseModel {
    var tagName: String?
    var photoURL: String?
}
