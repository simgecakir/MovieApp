//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Simge on 1.08.2021.
//

import UIKit

class SplashViewController: UIViewController {

    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        SplashService.shared.fetchRemoteConfig(){ title in
            DispatchQueue.main.async {
                self.titleLabel.text = title
                }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigateToHome()
        }
        
    }
    
    func configureUI(){
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .black
            
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 50)
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ (make) in
            make.centerX.centerY.equalToSuperview()
            make.trailing.leading.equalToSuperview()
        }
    }
    
    private func navigateToHome() {
                      
        let nav = UINavigationController(rootViewController: HomeViewController())
        
        let w = UIApplication.shared.keyWindow
        w?.rootViewController = nav
        w?.makeKeyAndVisible()
    }
    
}
