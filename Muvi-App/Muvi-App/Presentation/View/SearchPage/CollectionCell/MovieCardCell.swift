//
//  MovieCardCell.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit
import SDWebImage

class MovieCardCell: UICollectionViewCell {
    @IBOutlet weak var lblTitleMovie: UILabel!
    @IBOutlet weak var lblCastMovie: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        imgMovie.layer.cornerRadius = 4
        contentView.isUserInteractionEnabled = true
    }
    
    func configure(datasource: MoviesModel? = nil) {
        lblTitleMovie.text = datasource?.movieTitle
        lblCastMovie.text = datasource?.overview
        imgMovie.sd_setImage(with: URL(string: datasource?.posterUrlPath ?? ""), placeholderImage: UIImage(named: "imgPlaceholder"))
    }

}
