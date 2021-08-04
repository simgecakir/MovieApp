//
//  UIViewController + Extention.swift
//  MovieApp
//
//  Created by Simge on 4.08.2021.
//


import UIKit

extension UIViewController {
    
    func convertImage(url: String) -> Data? {
        
        if let url = URL(string: url) {
            if let imageData = try? Data(contentsOf: url){
                return imageData
            }
        }
        return nil
    }
    
}

