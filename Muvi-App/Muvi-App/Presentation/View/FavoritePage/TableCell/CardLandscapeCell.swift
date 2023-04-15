//
//  CardLandscapeCell.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

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
    
    private func setupView() {

    }
    
    func configure(data: MoviesModel) {
        lblTitleMovie.text = data.movieTitle
        lblReleaseDate.text = data.releaseDate
        lblGenreMovie.text = data.posterUrlPath
//        imgMovie.image = UIImage(named: data.posterUrlPath)
    }
    
}
