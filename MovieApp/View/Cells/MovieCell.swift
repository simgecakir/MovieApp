//
//  MovieCell.swift
//  MovieApp
//
//  Created by Simge on 1.08.2021.
//

import UIKit
import SnapKit

class MovieCell: UICollectionViewCell {
    
    static var cellName = "MovieCell"
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let yearLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String?, year: String?, poster: Data?){
        
        if let data = poster {
            contentImageView.image = UIImage(data: data)
        } else {
            contentImageView.image = UIImage(systemName: "film")
        }
        titleLabel.text = title ?? "Movie Title"
        yearLabel.text = year ?? "Year"
    }
    
    private func bindViews() {
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints{ (make) in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        
        containerView.addSubview(contentImageView)
        contentImageView.snp.makeConstraints{ (make) in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        
        containerView.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints{ (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ (make) in
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview()
        }
        
        containerView.addSubview(yearLabel)
        yearLabel.snp.makeConstraints{ (make) in
            make.bottom.equalTo(titleLabel.snp.top).offset(-5)
            make.height.equalTo(15)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview()
        }
    }
}
