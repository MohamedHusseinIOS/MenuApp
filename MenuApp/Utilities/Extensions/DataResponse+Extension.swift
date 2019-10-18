//
//  DataResponse+Extension.swift
//  pagination-demo
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import Alamofire

extension DataResponse {
    
    func interceptResuest(_ url: String, _ params: Parameters?){
    
        print("================(\(url))============== \n")
        print("parameters =======> \(params ?? [:]) \n")
        print("Header =====> \(request?.allHTTPHeaderFields ?? [:]) \n")
        print(response?.url?.absoluteURL ?? "")
        print("statusCode =====> \(response?.statusCode ?? 00000) \n")
        print("result ======> ", result.value ?? "")
    }
}
