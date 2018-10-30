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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(poster: String? = nil, title: String?, genre: String?, releaseDate: String?) {
        if let posterImage = poster {
            Util.setMovieImageView(imageView: posterImageView, url: URL(string: posterImage)!)
        }
        movieTitleLabel.text = title
        genreLabel.text = genre
        releaseDateLabel.text = "\("Release date"): \(Util.formatDate(dateFormattedAsString: releaseDate) ?? "")"
    }

}
