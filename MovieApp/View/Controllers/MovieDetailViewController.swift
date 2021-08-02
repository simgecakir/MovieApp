//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Simge on 30.07.2021.
//

import UIKit
import SnapKit

class MovieDetailViewController: UIViewController {

//    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "MovieDetail"  //movie.title
        navigationController?.navigationBar.prefersLargeTitles = false
        
        configureUI()
    }
    
    private func configureUI(){
        
        let scrollView: UIScrollView = {
            let scroll = UIScrollView()
            scroll.alwaysBounceHorizontal = false
            scroll.alwaysBounceVertical = true
            return scroll
        }()
        
        let contentView = UIView()
        
        let poster: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "test")
            return imageView
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Movie Name"
            label.font = UIFont.boldSystemFont(ofSize: 27)
            return label
        }()
        
        let yearLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.text = "\("Year"):  2019"
            return label
        }()
        
        let genreLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.text = "\("Genre"):  Action"
            return label
        }()
        
        let runtimeLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.text = "\("Runtime"):  120 min"
            return label
        }()
        
        let summaryLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.text = """
\("Summary")

Sizin için tüm konuları aktif hale getirdik. Konu başlıklarını ekleyip çıkabilirsiniz. Aşağıda bulunan seçili Konulardan ilgilenmediklerinizi, çıkararak akışınızı özelleştirebilirsiniz
"""
            label.numberOfLines = 0
            return label
        }()
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints{ (make) in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints{ (make) in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
            make.bottom.equalToSuperview()
        }
        
        contentView.addSubview(poster)
        poster.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(poster.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        contentView.addSubview(yearLabel)
        yearLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        contentView.addSubview(genreLabel)
        genreLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(yearLabel.snp.bottomMargin).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        contentView.addSubview(runtimeLabel)
        runtimeLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(genreLabel.snp.bottomMargin).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        contentView.addSubview(summaryLabel)
        summaryLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(runtimeLabel.snp.bottomMargin).offset(20)
            make.leading.trailing.equalToSuperview()
        }
    }
}
