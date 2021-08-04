//
//  ViewController.swift
//  MovieApp
//
//  Created by Simge on 30.07.2021.
//

import UIKit
import Firebase
import SnapKit

class HomeViewController: UIViewController {

    let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    let searchController = UISearchController()
    
    var collectionView: UICollectionView!
    var filteredMovies: [Movie] = []
    var movies: [Movie] = []
    var movieDetail: MovieDetail?
    var isFiltering = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        getAllMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureView(){

        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.isHidden = false
        
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
        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.cellName)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.bottom.trailing.leading.equalToSuperview()
        }
        
    }
    
    private func configureSearchController() {
        
        searchController.searchBar.placeholder = "Search Movie"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    private func configureSpinner(){
        
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        spinner.style = .medium
        view.addSubview(spinner)
    }
    
    private func getAllMovies() {
        
        DispatchQueue.main.async {
            self.spinner.isHidden = false
            self.spinner.startAnimating()
            
            APIService.shared.getAllMovies { (movieList,result) in
                if result{
                    self.movies = movieList!
                    self.collectionView.reloadData()
                }
            }
        }
        spinner.stopAnimating()
    }
    
    private func getMovie(moviID: String) {

        DispatchQueue.main.async{
            APIService.shared.getMovie(imdbID: moviID) { (movie,result) in
                if result{
                    self.movieDetail = movie
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
        
        if isFiltering {
            if filteredMovies.count == 0 {
                self.collectionView.setEmptyMessage("Movie not Found", image: UIImage(systemName: "film")!)
            } else {
                self.collectionView.backgroundView = nil
            }
            return filteredMovies.count
        }
        self.collectionView.backgroundView = nil
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.cellName, for: indexPath) as! MovieCell
        var movie: Movie!
        
        if isFiltering {
            movie = filteredMovies[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }
        
        let imageData = convertImage(url: movie.Poster!)
        cell.configure(title: movie.Title, year: movie.Year, poster: imageData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = MovieDetailViewController()
        DispatchQueue.main.async { [self] in
        
            var selectedMovie:Movie!
            if isFiltering == false{
                selectedMovie = movies[indexPath.row]
                getMovie(moviID: selectedMovie.imdbID!)
            } else {
                selectedMovie = filteredMovies[indexPath.row]
                getMovie(moviID: selectedMovie.imdbID!)
            }
            
            Analytics.logEvent("movie_selected", parameters: ["movie_title": selectedMovie.Title!, "movie_id": selectedMovie.imdbID!])
            
            if movieDetail != nil && movieDetail?.imdbID == selectedMovie.imdbID {
                vc.movie = movieDetail
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            getAllMovies()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.width / 2 - 20), height: view.frame.height * 0.5)
    }
    
}

extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.isActive {
            if let text = searchController.searchBar.text {
                isFiltering = true
                filteredMovies = movies.filter{ $0.Title!.lowercased().contains(text.lowercased()) }
            }
        } else {
            isFiltering = false
        }
        self.collectionView.reloadData()
    }
    
}
