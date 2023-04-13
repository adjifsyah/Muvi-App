//
//  BannerCell.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class BannerCell: UICollectionViewCell {
    @IBOutlet weak var imgBanner: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(imgName: String) {
        imgBanner.image = UIImage(named: imgName)
    }

}
