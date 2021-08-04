//
//  APIService.swift
//  MovieApp
//
//  Created by Simge on 30.07.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIService {
    
    static let shared = APIService()

    let baseURL = "http://www.omdbapi.com/"
    let apiKey = "264e2e6c"
    
    func getAllMovies(callback: @escaping([Movie]?, Bool) -> ()){

        let url = "\(baseURL)?s=\("bat")&r=json&apikey=\(apiKey)"
        
        Alamofire.AF.request(url).responseJSON{ response in
            do {
                let data = try JSONDecoder().decode(MovieContainer.self, from: response.data!)
                callback(data.Search, true)
                } catch {
                    print("error while parse the data")
                    callback(nil, false)
            }
        }.resume()
    }
    
    
    func getMovie(imdbID: String, callback: @escaping(MovieDetail?, Bool) -> ()) {
        
        let url = "\(baseURL)?i=\(imdbID)&r=json&apikey=\(apiKey)"
//        http://www.omdbapi.com/?i=tt0096895&r=json&apikey=264e2e6c

        Alamofire.AF.request(url).responseJSON{ response in
            do {
                let data = try JSONDecoder().decode(MovieDetail.self, from: response.data!)
                callback(data, true)
                } catch {
                    print("error while parse the data")
                    callback(nil, false)
                }
        }
    }
    
}
