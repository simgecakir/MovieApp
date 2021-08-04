//
//  SplashService.swift
//  MovieApp
//
//  Created by Simge on 2.08.2021.
//

import Foundation
import Firebase

class SplashService {
    
    static let shared = SplashService()
    var remoteConfig = RemoteConfig.remoteConfig()
    
    func setRemoteConfigDefaults(){
        let defaultValue = [ "companyName" : "default company name" as NSObject]
        remoteConfig.setDefaults(defaultValue)
    }
    
    func fetchRemoteConfig(callback: @escaping(String?) -> ()){
        
        setRemoteConfigDefaults()
        
        let settings = RemoteConfigSettings()
        remoteConfig.configSettings = settings
        remoteConfig.fetch(){ [unowned self] (status, error) -> Void in
              if status == .success {
                print("Config fetched!")
                self.remoteConfig.activate { changed, error in
                    callback(self.remoteConfig.configValue(forKey: "companyName").stringValue)
                }
              } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
              }
        }
    }
    
}
