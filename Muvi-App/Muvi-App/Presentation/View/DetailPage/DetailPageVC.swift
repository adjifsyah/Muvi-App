//
//  DetailPageVC.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class DetailPageVC: UIViewController {
    @IBOutlet weak var lblTitleDetail: UILabel!
    @IBOutlet weak var lblDurationMovie: UILabel!
    @IBOutlet weak var lblGenresMovie: UILabel!
    @IBOutlet weak var lblOverviewMovie: UILabel!
    @IBOutlet weak var lblPlaceholderCast: UILabel!
    @IBOutlet weak var imgMovieDetail: UIImageView!
    @IBOutlet weak var btnWatchMovie: UIButton!
    @IBOutlet weak var btnAddFavorite: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var cardCastCollection: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topConstraintScrollView: NSLayoutConstraint!
    
    var isFavorite: Bool = false
    
    var statusBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return statusBarHeight + 4
    }
    
    let viewModel: DetailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupBtn()
        validateFavorite()
        createGradient()
        setupCollectionView()
        setupConstraint()
    }
    
    private func validateFavorite() {
        btnAddFavorite.setTitle(isFavorite ? "Remove from Favorite" : "Add to Favorite", for: .normal)
    }
    
    func fetchData(by id: Int) {
        viewModel.fetchMoviePopular(movieId: id)
        viewModel.fetchCredit(by: id)

        viewModel.didFinishFetch = {
            self.configure(data: self.viewModel.detailMovie ?? nil)
            self.fetchLocal()
            self.validateFavorite()
        }
        
        viewModel.didFinishFetchCast = {
            self.cardCastCollection.reloadData()
        }
    }
    
    private func fetchLocal() {
        viewModel.retriveCoreData { res in
            switch res {
            case .success(let success):
                self.isFavorite = success.contains(where: ({ $0.movieTitle == self.lblTitleDetail.text}))
                self.validateFavorite()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configure(data: DetailMovies? = nil) {
        lblTitleDetail.text = data?.movieTitle ?? ""
        lblOverviewMovie.text = data?.overview ?? ""
        lblPlaceholderCast.text = "Cast"
        let genres = data?.movieGenres.map { $0.genre }.joined(separator: ", ")
        lblGenresMovie.text = genres ?? ""
        imgMovieDetail.sd_setImage(
            with: URL(string: data?.imgUrlPath ?? ""),
            placeholderImage: UIImage(named: "imgPlaceholder")
        )
    }
    
    private func setupBtn() {
        btnWatchMovie.layer.cornerRadius = 4
        
        btnAddFavorite.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12).cgColor
        btnAddFavorite.layer.cornerRadius = 4
        btnAddFavorite.layer.borderWidth = 1
    }
    
    private func setupCollectionView() {
        cardCastCollection.delegate = self
        cardCastCollection.dataSource = self
        scrollView.delegate = self
        
        let castNib = UINib(nibName: String(describing: CardCastView.self), bundle: nil)
        cardCastCollection.register(castNib, forCellWithReuseIdentifier: "castCell")
        
        flowLayout.itemSize = CGSize(width: 90, height: 134)

        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func createGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 3)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0, 0.25, 1]
        gradientLayer.frame = gradientView.bounds
        gradientView.layer.mask = gradientLayer
    }
    
    private func setupConstraint() {
        topConstraintScrollView.constant = -statusBarHeight
    }
    
    @IBAction func onTapAddFavorite(_ sender: UIButton) {
        isFavorite ? deleteFavorite() : saveFavorite()
    }
    
    private func saveFavorite() {
        let detailMovie = viewModel.detailMovie
        CoreDataManager.shared.save(moviesId: detailMovie?.movieId ?? 0, moviesTitle: detailMovie?.movieTitle ?? "", overview: detailMovie?.overview ?? "", releaseDate: detailMovie?.releaseDate ?? "", backdropPath: detailMovie?.imgUrlPath ?? "", posterPath: detailMovie?.imgUrlPath ?? "") { result in
            switch result {
            case .success(let success):
                let message = "Success save \(success) to favorite"
                AlertHelper.shared.showGeneralAlert(message: message, navigationController: self.navigationController!)
                self.fetchLocal()
                self.validateFavorite()
            case .failure(let failure):
                AlertHelper.shared.showGeneralAlert(message: failure.localizedDescription, navigationController: self.navigationController!)
            }
        }
    }
    
    private func deleteFavorite() {
        let detailMovie = viewModel.detailMovie
        CoreDataManager.shared.delete(detailMovie?.movieTitle ?? "") { result in
            switch result {
            case .success(let movieTitle):
                let message = "Success delete \(movieTitle) from favorite"
                AlertHelper.shared.showGeneralAlert(message: message, navigationController: self.navigationController!)
                self.fetchLocal()
                self.validateFavorite()
            case .failure(let error):
                AlertHelper.shared.showGeneralAlert(message: error.localizedDescription, navigationController: self.navigationController!)
            }
        }
    }
    
    @IBAction func onTapBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension DetailPageVC: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.datasourceCast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as? CardCastView else { return UICollectionViewCell() }
        let datasourceCast = viewModel.datasourceCast?[indexPath.row]
        castCell.configure(data: datasourceCast ?? nil)
        return castCell
    }
}

extension DetailPageVC {
    func hideBackButton() {
        UIView.animate(withDuration: 0.3) {
            self.btnBack.layer.opacity = 0
            self.btnBack.isEnabled = false
        }
    }
    
    func showBackButton() {
        UIView.animate(withDuration: 0.3) {
            self.btnBack.layer.opacity = 1
            self.btnBack.isEnabled = true
        }
    }
}
