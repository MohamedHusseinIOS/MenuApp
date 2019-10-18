//
//  ItemsHeaderView.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 18/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import UIKit

class ItemsHeader: UIView {

    @IBOutlet weak var tagImg: UIImageView!
    @IBOutlet weak var tagNameLbl: UILabel!
    
    
    static let id = "ItemsHeader"
    
    static func initFormNib() -> UIView? {
        guard let view = UINib(nibName: id, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView else { return UIView() }
        return view
    }
    
    func bindOn(tag: Tag) {
        tagNameLbl.text = tag.tagName!
        guard let url = URL(string: tag.photoURL!) else { return }
        tagImg.kf.setImage(with: url)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        self.frame = self.bounds
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
