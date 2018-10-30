//
//  DetailMovieViewController.swift
//  Upcoming Movies
//
//  Created by Mac-Mini on 30/10/18.
//  Copyright © 2018 Mac-Mini. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTitleLabelBig: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundTopImage: UIImageView!
    
    var movieTitle: String?
    var movieDescription: String?
    var genre: String?
    var releaseDate: String?
    var backgroundTopImagePath : String?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movieTitle = movieTitle {
            movieTitleLabel.text = movieTitle
            movieTitleLabelBig.text = movieTitle
        }
        
        if let movieDescription = movieDescription {
            descriptionLabel.text = movieDescription
        }
        
        if let genre = genre {
            genreLabel.text = "\("Genre: ")\(genre)"
        }
        
        if let releaseDate = releaseDate {
            releaseDateLabel.text = "\("Release date: ")\(Util.formatDate(dateFormattedAsString: releaseDate) ?? "")"
        }
        
        if let image = backgroundTopImagePath {
            let urlString = "\(Constants.TMDB_BACKDROP_IMAGE)\(image)"
            Util.setMovieImageView(imageView: backgroundTopImage, url: URL(string: urlString)!)
        }
    }
    
    //MARK: - Actions
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
