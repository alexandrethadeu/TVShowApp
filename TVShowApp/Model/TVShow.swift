//
//  TVShow.swift
//  TVShowApp
//
//  Created by Alexandre Thadeu  on 29/12/21.
//

import Foundation

struct TVShow: Codable, Identifiable {
    var id: Int64
    var posterPath: String?
    var backdropPath: String?
    var name: String
    var voteAverage: Float?
    var firstAirDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
    }
    
    var posterURL: URL {
        guard let urlString = posterPath else {
            return URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")!
        }
        return URL(string: "https://image.tmdb.org/t/p/w500/\(urlString)")!
    }
    
    var backdropURL: URL {
        guard let urlString = backdropPath else {
            return URL(string: "https://image.tmdb.org/t/p/w800/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")!
        }
        return URL(string: "https://image.tmdb.org/t/p/w500/\(urlString)")!
    }
    
    var voteAverageString: String {
        guard let voteAverage = self.voteAverage else {
            return "N/A"
        }
        return "\(voteAverage)"
    }
    
    var date: String {
        if let firstAirDate {
            return String(firstAirDate.prefix(4))
        }
        
        return "N/A"
    }
}
