//
//  FavoritePageVC.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class FavoritePageVC: UIViewController {
    @IBOutlet weak var moviesTableView: UITableView!
    
    var datasource: [MoviesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupTableView()
    }
    
    private func fetchData() {
        
    }
    
    private func setupTableView() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.estimatedRowHeight = UITableView.automaticDimension
        let favoriteNib = UINib(nibName: String(describing: CardLandscapeCell.self), bundle: nil)
        moviesTableView.register(favoriteNib, forCellReuseIdentifier: "favoriteCell")
    }
    
}

extension FavoritePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? CardLandscapeCell else { return UITableViewCell() }
        favoriteCell.configure(data: datasource[indexPath.row])
        return favoriteCell
    }
    
    
}
