//
//  TagsRouter.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import Alamofire

enum MenuRouter: URLRequestBuilder {
    
    case tags(_ page: Int)
    case items(_ tag: String)
    
    var path: String{
        switch self {
        case .tags(let page):
            return ServerPaths.tags.page(page)
        case .items(let tag):
            return ServerPaths.items.tag(tag)
        }
    }
    
    var header: HTTPHeaders {
        return ["Content-Type":"application/json"]
    }
    
    var parameters: Parameters?{
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
