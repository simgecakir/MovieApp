//
//  SplashViewController.swift
//  MovieApp
//
//  Created by Simge on 1.08.2021.
//

import UIKit
import Alamofire

class SplashViewController: UIViewController {

    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        configureUI()
        
        checkInternetConnection()
    }
    
    func configureUI(){
        
        navigationController?.navigationBar.isHidden = true
            
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 50)
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ (make) in
            make.centerX.centerY.equalToSuperview()
            make.trailing.leading.equalToSuperview()
        }
    }
    
    func checkInternetConnection() {

        if NetworkReachabilityManager()?.isReachable == true {
            
            SplashService.shared.fetchRemoteConfig(){ title in
                DispatchQueue.main.async {
                    self.titleLabel.text = title
                    }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.navigateToHome()
            }
        } else {
            internetConnectionAlert()
        }
        
    }
    
    func internetConnectionAlert(){
        
        let alert = UIAlertController(title: "No Internet Connection", message: "Please check if you connect to Wi-Fi", preferredStyle: .alert)
        let tryAgain = UIAlertAction(title: "Try Again", style: .default, handler: { _ in
            self.checkInternetConnection()
        })
        
        alert.addAction(tryAgain)
        present(alert, animated: true, completion: nil)
    }
        
    private func navigateToHome() {
                      
        navigationController!.viewControllers = [HomeViewController()]
        navigationController?.popToRootViewController(animated: true)
    }
    
}
