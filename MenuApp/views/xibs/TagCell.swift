//
//  TagCell.swift
//  MenuApp
//
//  Created by Mohamed Hussien on 16/10/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import UIKit
import Kingfisher
import Hero

class TagCell: UICollectionViewCell {
    
    @IBOutlet weak var tagImage: UIImageView!
    @IBOutlet weak var tagNameLbl: UILabel!
    
    static let id = "TagCell"
    
    
    
    func bindOn(tag: Tag) {
        tagNameLbl.text = tag.tagName!
        guard let url = URL(string: tag.photoURL!) else { return }
        tagImage.kf.setImage(with: url)
    }
    
    func bindOn(item: Item) {
        tagNameLbl.text = item.name
        guard let url = URL(string: item.photoUrl ?? "") else { return }
        tagImage.kf.setImage(with: url)
        tagImage.hero.id = item.name
    }
}
