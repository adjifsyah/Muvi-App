//
//  HomePageVC.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class HomePageVC: UIViewController {
    @IBOutlet weak var tblMoviesCategory: UITableView!
    
    var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        fetchData()
        setupTableView()
    }
    
    private func fetchData() {
        viewModel.fetchBanner()
        viewModel.fetchPopular()
        viewModel.fetchComingSoon()
        
    }
    
    private func setupTableView() {
        let bannerNib = UINib(nibName: String(describing: BannerListCell.self), bundle: nil)
        let popularNib = UINib(nibName: String(describing: CardViewCell.self), bundle: nil)
        let comingNib = UINib(nibName: String(describing: CardViewCell.self), bundle: nil)
        
        tblMoviesCategory.register(bannerNib, forCellReuseIdentifier: "bannerListCell")
        tblMoviesCategory.register(popularNib, forCellReuseIdentifier: "popularListCell")
        tblMoviesCategory.register(comingNib, forCellReuseIdentifier: "comingListCell")
    }
    
}

extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let bannerCell = tableView.dequeueReusableCell(withIdentifier: "bannerListCell", for: indexPath) as? BannerListCell,
            let popularCell = tableView.dequeueReusableCell(withIdentifier: "popularListCell", for: indexPath) as? CardViewCell,
            let comingCell = tableView.dequeueReusableCell(withIdentifier: "comingListCell", for: indexPath) as? CardViewCell
        else { return UITableViewCell() }
        
        let row = indexPath.row
        
        switch row {
        case 0:
            viewModel.didFinishFetchBanner = {
                bannerCell.configure(dataSource: self.viewModel.movieBanner ?? [])
            }
            bannerCell.navigationController = navigationController!
            return bannerCell
        case 1:
            viewModel.didFinishFetchPopular = {
                popularCell.configure(input: "Popular Movies", identifierCell: "popularCell", dataSource: self.viewModel.moviePopular ?? [])
            }
            popularCell.navigationController = navigationController!
            return popularCell
        case 2:
            viewModel.didFinishFetchComing = {
                comingCell.configure(input: "Coming Soon", identifierCell: "comingCell", dataSource: self.viewModel.movieComingSoon ?? [])
            }
            comingCell.navigationController = navigationController!
            return comingCell
        default:
            return UITableViewCell()
        }
    }

}
