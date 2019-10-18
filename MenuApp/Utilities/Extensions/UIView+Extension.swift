//
//  UIView+Extension.swift
//  pagination-demo
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    @available(iOS 11.0, *)
    var corners: CACornerMask{
        get{
            return self.layer.maskedCorners
        }
        set{
            self.layer.maskedCorners = newValue
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var clipToBounds: Bool{
        get{
            return self.clipsToBounds
        }
        set{
            self.clipsToBounds = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor?{
        get{
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set{
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat{
        get{
            return self.layer.borderWidth
        }
        set{
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize{
        get{
            return self.layer.shadowOffset
        }
        set{
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float{
        get{
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor?{
        get{
           return UIColor(cgColor: self.layer.shadowColor!)
        }
        set{
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowPath: CGPath?{
        get{
            return self.layer.shadowPath
        }
        set{
            self.layer.shadowPath = newValue
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat{
        get{
            return self.layer.shadowRadius
        }
        set{
            self.layer.shadowRadius = newValue
        }
    }
}
