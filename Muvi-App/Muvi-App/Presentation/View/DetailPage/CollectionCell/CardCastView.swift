//
//  CardCastView.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class CardCastView: UICollectionViewCell {

    @IBOutlet weak var lblCastMovie: UILabel!
    @IBOutlet weak var imgCastMovie: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        imgCastMovie.layer.cornerRadius = imgCastMovie.frame.height / 2
    }

    func configure(data: CastModel? = nil) {
        lblCastMovie.text = data?.nameCast
        imgCastMovie.sd_setImage(with: URL(string: data?.imageUrlString ?? ""), placeholderImage: UIImage(named: "imgPlaceholder"))
    }
}
