//
//  UpcomingMovies.swift
//  Upcoming Movies
//
//  Created by Mac-Mini on 29/10/18.
//  Copyright © 2018 Mac-Mini. All rights reserved.
//

import Foundation

struct UpcomingMovies : Codable {
    
    //MARK: Properties
    let results: [Movie]?
    let page, totalResults: Int?
    let dates: Dates?
    let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
    
    struct Dates: Codable {
        let maximum, minimum: String
    }
}

