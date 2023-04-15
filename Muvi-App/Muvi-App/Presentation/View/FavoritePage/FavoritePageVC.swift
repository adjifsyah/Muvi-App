//
//  FavoritePageVC.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class FavoritePageVC: UIViewController {
    @IBOutlet weak var searchToolbar: SearchToolbar!
    @IBOutlet weak var moviesTableView: UITableView!
    
    var viewModel: FavMovieViewModel = FavMovieViewModel()
    var getIndexPath: IndexPath = IndexPath(row: -1, section: -1)
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        GeneralLoading.shared.showLoading(getNavigation: navigationController!)
        setupView()
    }
    
    private func setupView() {
        setupTableView()
        setupSearcToolbar()
    }
    
    private func fetchData() {
        viewModel.fetchFavoriteMovie { result in
            switch result {
            case .success(let success):
                GeneralLoading.shared.hideLoading(getNavigation: self.navigationController!)
                let filterData = success?.filter { $0.movieTitle != "" } ?? []
                self.moviesTableView.reloadData()
            case .failure(let error):
                AlertHelper.shared.showGeneralAlert(message: error.localizedDescription, navigationController: self.navigationController!)
            }
        }
    }
    
    private func validateView() {
        let isTextFieldEmpty = searchToolbar.searchTextField.text == ""

//        setMessage(isDataEmpty: false)
    }
    
    private func setupSearcToolbar() {
        searchToolbar.searchTextField.delegate = self
        searchToolbar.btnSearch.addTarget(self, action: #selector(onTapSearch), for: .touchUpInside)
    }
    
    private func setupTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.estimatedRowHeight = UITableView.automaticDimension
        let favoriteNib = UINib(nibName: String(describing: CardLandscapeCell.self), bundle: nil)
        moviesTableView.register(favoriteNib, forCellReuseIdentifier: "favoriteCell")
    }
    
    private func isSearchActive() {
        searchToolbar.searchTextField.text == "" ? searchToolbar.setInactiveTF() : searchToolbar.setActiveTF()
    }
    
    @objc
    private func onTapSearch() {
        isSearchActive()
        
        if searchToolbar.searchTextField.text == "" {
            viewModel.movieFilter = viewModel.detailMovie
            GeneralLoading.shared.hideLoading(getNavigation: navigationController!)
        } else {
            GeneralLoading.shared.showLoading(getNavigation: navigationController!)
            viewModel.searchMovies(title: searchToolbar.searchTextField.text!, completion: {
                GeneralLoading.shared.hideLoading(getNavigation: self.navigationController!)
            })
            moviesTableView.reloadData()
        }
    }
    
    @objc
    func deleteFavoriteMovie(sender: UITapGestureRecognizer) {
        let section = sender.view!.tag / 100
        let row = sender.view!.tag % 100
        getIndexPath = IndexPath(row: row, section: section)
        let selectedMovieTitle = viewModel.movieFilter?[getIndexPath.row].movieTitle ?? ""
        viewModel.removeFavorite(byTitle: selectedMovieTitle) { result in
            switch result {
            case .success(let res):
                let message = "Success remove \(res) from favorite"
                self.fetchData()
                AlertHelper.shared.showGeneralAlert(message: message, navigationController: self.navigationController!)
            case .failure(let err):
                let message = "fail remove \(err) from favorite"
                self.moviesTableView.reloadData()
            }
        }
    }
}

extension FavoritePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieFilter?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? CardLandscapeCell else { return UITableViewCell() }
        let movieFavorite = viewModel.movieFilter
        let onTapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteFavoriteMovie))
        favoriteCell.addAction(gesture: onTapGesture)
        favoriteCell.btnFavorite.tag = (indexPath.section * 100) + indexPath.row
        favoriteCell.configure(data: movieFavorite?[indexPath.row])
        return favoriteCell
    }
}


extension FavoritePageVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        isSearchActive()
        viewModel.movieFilter = textField.text == "" ? viewModel.detailMovie?.filter { $0.movieTitle != "" } : []
        moviesTableView.reloadData()
    }
}
