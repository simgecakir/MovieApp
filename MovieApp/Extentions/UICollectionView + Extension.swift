//
//  UICollectionView + Extention.swift
//  MovieApp
//
//  Created by Simge on 3.08.2021.
//

import UIKit

extension UICollectionView {
    
    func setEmptyMessage(_ message: String, image: UIImage){
        
        let containerView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.width, height: self.bounds.height))
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .gray

        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "arial-boldmt", size: 25)
        messageLabel.sizeToFit()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 200).isActive = true
        imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        containerView.addSubview(messageLabel)
        messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.backgroundView = containerView
    }
    
}
