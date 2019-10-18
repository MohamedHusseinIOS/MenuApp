//
//  Data+Extension.swift
//  pagination-demo
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation

extension Data {
    static func convertToData(_ obj: Any) -> Data? {
        var data: Data?
        if let jsonString = obj as? String {
            let result = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            data = result
        } else if let jsonArrayOfDic = obj as? [[String: AnyObject]] {
            do {
                let result = try JSONSerialization.data(withJSONObject: jsonArrayOfDic, options: .prettyPrinted)
                data = result
            } catch {
                data = nil
            }
        } else if let jsonDic = obj as? [String: AnyObject] {
            do {
                let result = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
                data = result
            } catch {
                data = nil
            }
        }
        return data
    }
}
