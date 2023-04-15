//
//  SearchPageVC.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class SearchPageVC: UIViewController {
    @IBOutlet weak var searchToolbar: SearchToolbar!
    @IBOutlet weak var lblPlaceholderSearch: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var dataStackView: UIStackView!
    @IBOutlet weak var messageStackView: UIStackView!
    @IBOutlet weak var lblMessage: UILabel!
    
    var viewModel: SearchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        fetchMovies()
        validateView()
        setupAction()
        setupSearcToolbar()
        setupCollectionView()
    }
    
    private func fetchMovies() {
        viewModel.fetchMoviePopular()
        
        viewModel.didFinishFetchPopular = {
            self.moviesCollectionView.reloadData()
            self.validateView()
        }
    }
    
    private func validateView() {
        let isTextFieldEmpty = searchToolbar.searchTextField.text == ""
        lblPlaceholderSearch.isHidden = isTextFieldEmpty
        lblPlaceholderSearch.text = "Showing result of '\(searchToolbar.searchTextField.text!)' "
        dataStackView.isHidden = viewModel.movieFilter == nil
        setMessage(isDataEmpty: false)
    }
    
    private func setupAction() {
//        let onTapCancelSearch = UITapGestureRecognizer(target: self, action: #selector(onTapCancelSearch))
//        view.addGestureRecognizer(onTapCancelSearch)
    }
    
    private func setupSearcToolbar() {
        searchToolbar.searchTextField.delegate = self
        searchToolbar.btnSearch.addTarget(self, action: #selector(onTapSearch), for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        let cardNib = UINib(nibName: String(describing: MovieCardCell.self), bundle: nil)
        moviesCollectionView.register(cardNib, forCellWithReuseIdentifier: "movieCard")
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let centerSpace: CGFloat = 15
        let availableWidth = moviesCollectionView.frame.width - centerSpace
        let widthPerItem = availableWidth / 2
        flowLayout.itemSize = CGSize(width: widthPerItem, height: 264)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
    }
    
    private func setMessage(isDataEmpty: Bool) {
        let welcomeMessage = "What are you looking for ?"
        let emptyData = "Data not found"
        lblMessage.text = isDataEmpty ? emptyData : welcomeMessage
        
        messageStackView.isHidden = !(viewModel.movieFilter == nil)
    }
    
    private func isSearchActive() {
        searchToolbar.searchTextField.text == "" ? searchToolbar.setInactiveTF() : searchToolbar.setActiveTF()
    }
}

extension SearchPageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieFilter?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCard", for: indexPath) as? MovieCardCell else { return UICollectionViewCell() }
        let moviePopular = viewModel.movieFilter?[indexPath.row]
        movieCardCell.configure(datasource: moviePopular)
        return movieCardCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movieFilter?[indexPath.row].movieId ?? 0
        viewModel.goToDetailView(by: selectedMovie, nav: navigationController!)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        searchToolbar.setInactiveTF()
    }
}

extension SearchPageVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        isSearchActive()
        viewModel.movieFilter = textField.text == "" ? viewModel.moviePopular : []
        moviesCollectionView.reloadData()
    }
}

extension SearchPageVC {
    @objc
    private func onTapCancelSearch() {
        view.endEditing(true)
        searchToolbar.setInactiveTF()
    }
    
    @objc
    private func onTapSearch() {
        isSearchActive()
        
        if searchToolbar.searchTextField.text == "" {
            viewModel.movieFilter = viewModel.moviePopular
        } else {
            viewModel.searchMovies(title: searchToolbar.searchTextField.text!)
        }
    }
}
