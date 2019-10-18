//
//  String+Extension.swift
//  pagination-demo
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import UIKit

extension String{

    func clickableString(gotolink link: String, fontName: String, fontSize: CGFloat = 17) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: self.count)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.link, value: URL(string: link)!, range: range)
        attributedString.addAttribute(.font, value: UIFont(name: fontName, size: fontSize)!, range: range)
        return attributedString
    }

    func attributedString(fontName: String, fontSize: CGFloat = 17, color: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))->NSMutableAttributedString{
        let range = NSRange(location: 0, length: self.count)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedString.addAttribute(.font, value: UIFont(name: fontName, size: fontSize)!, range: range)
        return attributedString
    }
    
    func addQureyParam(key:String, value: String, lastParam: Bool) -> String {
        let param = "\(key)=\(value)"
        return lastParam ? self + param : self + param + "&"
    }
}
