//
//  CardCell.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit
import SDWebImage

class CardCell: UICollectionViewCell {
    @IBOutlet weak var vwBackground: UIView!
    
    @IBOutlet weak var imgCardView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func configure(imgUrlString: String) {
        imgCardView.sd_setImage(with: URL(string: imgUrlString), placeholderImage: UIImage(named: "imgPlaceholder"))
    }
}
