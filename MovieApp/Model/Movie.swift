//
//  Movie.swift
//  MovieApp
//
//  Created by Simge on 30.07.2021.
//

import Foundation
import ObjectMapper

struct Movie: Mappable {
    
    var title: String?
    var year: String?
    var runtime: String?
    var genre: String?
    var director: String?
    var actors: String?
    var plot: String?
    var language: String?
    var country: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        title       <- map["Title"]
        year        <- map["Year"]
        runtime     <- map["Runtime"]
        genre       <- map["Genre"]
        director    <- map["Director"]
        actors      <- map["Actors"]
        plot        <- map["Plot"]
        language    <- map["Language"]
        country     <- map["Country"]
    }
}
