//
//  GetMovies.swift
//  Upcoming Movies
//
//  Created by Mac-Mini on 29/10/18.
//  Copyright © 2018 Mac-Mini. All rights reserved.
//

import Foundation

class GetUpcomingMovies: RequestType {

    typealias ResponseType = UpcomingMovies
    var page : Int
    
    var data: RequestData {
        let url = "\(Constants.TMDB_URL)\(Constants.UPCOMING_MOVIES)?\(Constants.API_KEY_PREFIX)\(Constants.API_KEY)\(Constants.PAGE)\(page)"
        print (url)
        return RequestData(path: url, method: "\(Constants.GET)")
    }
    
    init(page: Int) {
        self.page = page
    }
}
