//
//  APIService.swift
//  MovieApp
//
//  Created by Simge on 30.07.2021.
//

import Foundation
import Alamofire

class APIService {
    
    static let shared = APIService()

    let baseURL = "http://www.omdbapi.com/"
    let apiKey = "264e2e6c"

    
    func getAllMovies(callback: @escaping([[String:Any]]?, Bool) -> ()) {

        let url = "\(baseURL)?s=\("bat")&r=json&apikey=\(apiKey)"
        
        AF.request(url).responseJSON(){ response in
                switch response.result{
                case .success(let jsonData):
                    if let response = jsonData as? Dictionary<String,Any> {
                        let movieList = response["Search"] as? [[String : Any]]
                        callback(movieList, true)
                    } else {
                        print("JSON parse error")
                        callback(nil, false)
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    callback(nil,false)
                }
            }
    }

}
