//
//  HomePageVC.swift
//  Muvi-App
//
//  Created by Adji Firmansyah on 13/04/23.
//

import UIKit

class HomePageVC: UIViewController {
    @IBOutlet weak var tblMoviesCategory: UITableView!
    
    let dataSource = ResponseMovies(listMovies: [
        RemoteMoviesModel(movieId: 502356, movieTitle: "The Super Mario Bros. Movie", overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.", releaseDate: "2023-04-05", backdropUrlPath: "banner", posterUrlPath: "banner"),
        RemoteMoviesModel(movieId: 502356, movieTitle: "Murder Mystery 2", overview: "After starting their own detective agency, Nick and Audrey Spitz land a career-making case when their billionaire pal is kidnapped from his wedding.", releaseDate: "2023-04-05", backdropUrlPath: "banner", posterUrlPath: "banner"),
        RemoteMoviesModel(movieId: 502356, movieTitle: "Shazam! Fury of the Gods", overview: "Billy Batson and his foster siblings, who transform into superheroes by saying Shazam!, are forced to get back into action and fight the Daughters of Atlas, who they must stop from using a weapon that could destroy the world.", releaseDate: "2023-04-05", backdropUrlPath: "banner", posterUrlPath: "banner"),
        RemoteMoviesModel(movieId: 502356, movieTitle: "John Wick: Chapter 4", overview: "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.", releaseDate: "2023-04-05", backdropUrlPath: "banner", posterUrlPath: "banner"),

        RemoteMoviesModel(movieId: 502356, movieTitle: "The Pope's Exorcist", overview: "Father Gabriele Amorth, Chief Exorcist of the Vatican, investigates a young boy's terrifying possession and ends up uncovering a centuries-old conspiracy the Vatican has desperately tried to keep hidden.", releaseDate: "2023-04-05", backdropUrlPath: "banner", posterUrlPath: "banner"),
        RemoteMoviesModel(movieId: 502356, movieTitle: "Cocaine Bear", overview: "Inspired by a true story, an oddball group of cops, criminals, tourists and teens converge in a Georgia forest where a 500-pound black bear goes on a murderous rampage after unintentionally ingesting cocaine.", releaseDate: "2023-04-05", backdropUrlPath: "banner", posterUrlPath: "banner"),
        RemoteMoviesModel(movieId: 502356, movieTitle: "Attack on Titan", overview: "As viable water is depleted on Earth, a mission is sent to Saturn's moon Titan to retrieve sustainable H2O reserves from its alien inhabitants. But just as the humans acquire the precious resource, they are attacked by Titan rebels, who don't trust that the Earthlings will leave in peace.", releaseDate: "2023-04-05", backdropUrlPath: "banner", posterUrlPath: "banner"),

        RemoteMoviesModel(movieId: 502356, movieTitle: "Winnie the Pooh: Blood and Honey", overview: "Christopher Robin is headed off to college and he has abandoned his old friends, Pooh and Piglet, which then leads to the duo embracing their inner monsters.", releaseDate: "2023-04-05", backdropUrlPath: "banner", posterUrlPath: "banner")
    ])
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
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
            bannerCell.configure(dataSource: dataSource.listMovies)
            return bannerCell
        case 1:
            popularCell.configure(input: "Popular Movies", identifierCell: "popularCell", dataSource: dataSource.listMovies)
            return popularCell
        case 2:
            comingCell.configure(input: "Coming Soon", identifierCell: "comingCell", dataSource: dataSource.listMovies)
            return comingCell
        default:
            return UITableViewCell()
        }
    }

}
