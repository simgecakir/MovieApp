//
//  MovieDetail.swift
//  MovieApp
//
//  Created by Simge on 3.08.2021.
//

import Foundation

struct MovieDetail: Codable { 
    
    var Title: String?
    var Year: String?
    var imdbID: String?
    var Poster: String?
    var Genre: String
    var Runtime: String?
    var Plot: String?
    var Released: String?
    var Rated: String?
    var Writer: String?
    var Actors: String?
    var Language: String?
    var Country: String?
    var Awards: String?
    var Metascore: String?
    var imdbRating: String?
    var imdbVotes: String
    var Ratings: [Rating]?
    var `Type`: String?
    var DVD: String?
    var BoxOffice: String
    var Production: String?
    var Website: String?
    var Response: String?
}

struct Rating: Codable {
    var Source: String?
    var Value: String?
}
