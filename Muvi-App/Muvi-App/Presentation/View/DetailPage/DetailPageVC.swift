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
    
    var statusBarHeight: CGFloat {
        var statusBarHeight: CGFloat = 0
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        return statusBarHeight + 4
    }
    
    lazy var yPoint = scrollView.contentOffset.y
    
    var startPointY: CGFloat {
        scrollView.contentOffset.y
    }
    
    let viewModel: DetailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupBtn()
        createGradient()
        setupCollectionView()
        setupConstraint()
    }
    
    func fetchData(by id: Int) {
        viewModel.fetchMoviePopular(movieId: id)
        viewModel.fetchCredit(by: id)

        viewModel.didFinishFetch = {
            self.configure(data: self.viewModel.detailMovie ?? nil)
        }
        
        viewModel.didFinishFetchCast = {
            self.cardCastCollection.reloadData()
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        yPoint -= scrollView.contentOffset.y
        yPoint == imgMovieDetail.frame.height / 2 ? hideBackButton() : showBackButton()
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
