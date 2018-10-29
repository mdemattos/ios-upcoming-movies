//
//  GetMovieDetail.swift
//  Upcoming Movies
//
//  Created by Mac-Mini on 29/10/18.
//  Copyright © 2018 Mac-Mini. All rights reserved.
//

import Foundation

class GetMovieDetail: RequestType {
    var movieId : String
    typealias ResponseType = Movie
    var data: RequestData {
        let url = "\(Constants.TMDB_URL)\(Constants.MOVIE_DETAIL)\(movieId)?\(Constants.API_KEY_PREFIX)\(Constants.API_KEY)"
        print (url)
        return RequestData(path: url, method: "\(Constants.GET)")
    }
    
    init(movieId: String) {
        self.movieId = movieId
    }
    
}
