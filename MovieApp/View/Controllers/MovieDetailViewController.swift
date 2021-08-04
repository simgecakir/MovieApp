//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Simge on 30.07.2021.
//

import UIKit
import SnapKit

class MovieDetailViewController: UIViewController {

    var movie: MovieDetail!

    let group = DispatchGroup()
    let serialQueue = DispatchQueue(label: "serialQueue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configureUI(){
        
        view.backgroundColor = .white
        navigationItem.title = "Movie Detail"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        
        let scrollView: UIScrollView = {
            let scroll = UIScrollView()
            scroll.alwaysBounceHorizontal = false
            scroll.alwaysBounceVertical = true
            return scroll
        }()
        
        let containerView = UIView()

        let posterView: UIImageView = {
            let imageView = UIImageView()
            
            if let poster = movie!.Poster {
                let data = convertImage(url: poster)
                imageView.image = UIImage(data: data!)
            } else {
                imageView.image = UIImage(systemName: "film")
            }
            imageView.contentMode = .scaleToFill
            return imageView
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = movie!.Title
            label.numberOfLines = 0
            label.font = UIFont.boldSystemFont(ofSize: 27)
            return label
        }()
        
        let yearLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.text = "\("Year"):  \(movie!.Year!)"
            return label
        }()
        
        let genreLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.text = "\("Genre"):  \(movie!.Genre)"
            return label
        }()
        
        let runtimeLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.text = "\("Runtime"):  \(movie!.Runtime!)"
            return label
        }()
        
        let summaryLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.text = "Summary: \(movie!.Plot!)"
            label.numberOfLines = 0
            return label
        }()
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{ (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.bottom.equalToSuperview()
        }
        
        containerView.addSubview(posterView)
        posterView.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(posterView.snp.bottomMargin).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        containerView.addSubview(yearLabel)
        yearLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        containerView.addSubview(genreLabel)
        genreLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(yearLabel.snp.bottomMargin).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        containerView.addSubview(runtimeLabel)
        runtimeLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(genreLabel.snp.bottomMargin).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        containerView.addSubview(summaryLabel)
        summaryLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(runtimeLabel.snp.bottomMargin).offset(20)
            make.leading.trailing.equalToSuperview()
        }
    }
    
}
