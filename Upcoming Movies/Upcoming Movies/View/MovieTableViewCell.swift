//
//  MovieTableViewCell.swift
//  Upcoming Movies
//
//  Created by Mac-Mini on 29/10/18.
//  Copyright © 2018 Mac-Mini. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var movieTitle : String?
    var releaseDate : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let title = movieTitle {
            movieTitleLabel.text = title
        }
        
        if let releaseDate = releaseDate {
            releaseDateLabel.text = releaseDate
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
