//
//  BannerListCell.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class BannerListCell: UITableViewCell {
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    private var bannerDataSource: [MoviesModel] = []
    private let screenSize = UIScreen.main.bounds
    
    let viewModel: HomeViewModel = HomeViewModel()
    var navigationController: UINavigationController? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        let bannerNib = UINib(nibName: String(describing: BannerCell.self), bundle: nil)
        bannerCollectionView.register(bannerNib, forCellWithReuseIdentifier: "bannerCell")
        
        flowLayout.itemSize =  CGSize(width: screenSize.width, height: 261)
        flowLayout.minimumLineSpacing = 0
        
    }
    
    func configure(dataSource: [MoviesModel]) {
        bannerDataSource = dataSource.filter { $0.posterUrlPath.contains("jpg")}
        bannerCollectionView.reloadData()
    }

    
}

extension BannerListCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bannerDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as? BannerCell else { return UICollectionViewCell() }
        let imgBanner = bannerDataSource[indexPath.row]
        bannerCell.configure(imgUrlString: imgBanner.posterUrlPath)
        return bannerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = bannerDataSource[indexPath.row].movieId
        viewModel.goToDetailView(by: selectedMovie, nav: navigationController!)
    }
    
}
