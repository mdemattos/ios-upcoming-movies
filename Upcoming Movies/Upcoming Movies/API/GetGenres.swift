//
//  GetGenres.swift
//  Upcoming Movies
//
//  Created by Mac-Mini on 30/10/18.
//  Copyright © 2018 Mac-Mini. All rights reserved.
//

import Foundation

class GetGenres: RequestType {
    
    typealias ResponseType = Genres
    var data: RequestData {
        let url = "\(Constants.TMDB_URL)\(Constants.GENRES)?\(Constants.API_KEY_PREFIX)\(Constants.API_KEY)"
        print (url)
        return RequestData(path: url, method: "\(Constants.GET)")
    }
    
}
