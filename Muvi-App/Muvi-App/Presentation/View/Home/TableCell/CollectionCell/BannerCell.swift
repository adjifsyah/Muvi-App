//
//  BannerCell.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit
import SDWebImage

class BannerCell: UICollectionViewCell {
    @IBOutlet weak var imgBanner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(imgUrlString: String) {
        imgBanner.sd_setImage(with: URL(string: imgUrlString), placeholderImage: UIImage(named: "imgPlaceholder"))
    }

}
