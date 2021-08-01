//
//  ViewController.swift
//  MovieApp
//
//  Created by Simge on 30.07.2021.
//

import UIKit
import ObjectMapper
import SnapKit

class HomeViewController: UIViewController {

    var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(movies.count)
        configureView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func configureView(){

        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCollectionView()
        configureSearchController()
    }
    
    private func configureCollectionView() {
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.bottom.trailing.leading.equalToSuperview()
        }
        
    }
    
    private func configureSearchController() {
        
        searchController.searchBar.placeholder = "Search Movie"
//        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    private func getAllMovies() {
        
        APIService.shared.getAllMovies { (movieList,result) in
            if result{
                for movie in movieList! {
                    let mappingMovie = Mapper<Movie>().map(JSON: movie)
                    self.movies.append(mappingMovie!)
                }
            }
        }
        
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.contentImageView.image = UIImage(named: "test")
        cell.titleLabel.text = "Joker"
        cell.yearLabel.text = "2019"
//        cell.titleLabel.text = movies[indexPath.row].title
//        cell.yearLabel.text = movies[indexPath.row].year

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.width / 2 - 20), height: view.frame.height * 0.3)
    }
    
}

