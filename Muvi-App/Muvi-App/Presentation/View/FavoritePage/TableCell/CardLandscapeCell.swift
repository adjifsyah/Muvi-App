//
//  CardLandscapeCell.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit
import SDWebImage

class CardLandscapeCell: UITableViewCell {
    @IBOutlet weak var lblTitleMovie: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblGenreMovie: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var imgMovie: UIImageView!

    @IBOutlet weak var widthImageConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func addAction(gesture: UITapGestureRecognizer) {
        btnFavorite.addGestureRecognizer(gesture)
    }
    
    private func setupView() {

    }
    
    func configure(data: MoviesModel? = nil) {
        lblTitleMovie.text = data?.movieTitle
        lblReleaseDate.text = data?.releaseDate
        lblGenreMovie.text = data?.posterUrlPath
        imgMovie.sd_setImage(with: URL(string: data?.posterUrlPath ?? ""), placeholderImage: UIImage(named: "imgPlaceholder"))
    }
    
}
