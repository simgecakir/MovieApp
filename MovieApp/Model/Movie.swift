//
//  Movie.swift
//  MovieApp
//
//  Created by Simge on 30.07.2021.
//

import Foundation

struct MovieContainer: Codable {
  var Search: [Movie]?
  var totalResults: String?
  var Response: String?
}

struct Movie: Codable {
  var Title: String?
  var Year: String?
  var imdbID: String?
  var Poster: String?
}
