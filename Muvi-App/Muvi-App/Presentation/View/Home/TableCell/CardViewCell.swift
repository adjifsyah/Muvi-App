//
//  CardViewCell.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class CardViewCell: UITableViewCell {
    @IBOutlet weak var lblMoviesCategory: UILabel!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    private let screenSize = UIScreen.main.bounds
    private var moviesDatasource: [RemoteMoviesModel] = []
    private var idCell: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(input category: String, identifierCell: String,  dataSource: [RemoteMoviesModel]) {
        idCell = identifierCell
        setupCollectionView()
        lblMoviesCategory.text = category
        moviesDatasource = dataSource
        cardCollectionView.reloadData()
    }
    
    private func setupCollectionView() {
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        let cardNib = UINib(nibName: String(describing: CardCell.self), bundle: nil)
        cardCollectionView.register(cardNib, forCellWithReuseIdentifier: idCell)
        
        flowLayout.itemSize = CGSize(width: screenSize.width / 4, height: 157)
        flowLayout.minimumLineSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    
}

extension CardViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesDatasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as? CardCell else { return UICollectionViewCell() }
        let movieDataSource = moviesDatasource[indexPath.row]
        cardCell.configure(imgName: movieDataSource.backdropUrlPath)
        return cardCell
    }
    
    
}
