//
//  CardCell.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class CardCell: UICollectionViewCell {
    @IBOutlet weak var vwBackground: UIView!
    
    @IBOutlet weak var imgCardView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func configure(imgName: String) {
        imgCardView.image = UIImage(named: imgName)
    }
}
