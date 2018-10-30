//
//  UpcomingMoviesViewController.swift
//  Upcoming Movies
//
//  Created by Mac-Mini on 29/10/18.
//  Copyright © 2018 Mac-Mini. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var upcomingMoviesLabel: UILabel!
    @IBOutlet weak var previousMoviesButton: UIButton!
    @IBOutlet weak var seeMoreMoviesButton: UIButton!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    var genres: Genres?
    var movies: UpcomingMovies?
    var previousMovies = [Int: UpcomingMovies]()
    var currentPage = 0
    var finishedLoadingInitialTableCells = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        if genres == nil {
            getGenres()
        }
    }
    
    //MARK: - Actions
    @IBAction func seeMoreMovies(_ sender: UIButton) {
        previousMovies[currentPage] = movies
        currentPage = currentPage + 1
        showPreviousMoviesButton(true)
        finishedLoadingInitialTableCells = false
        
        // Check if next page already loaded to not make another request
        if (previousMovies[currentPage] == nil || previousMovies.isEmpty) {
            showActivityIndicator()
            getUpcomingMovies(page: currentPage+1)
        } else {
            displayMoviesOnTableView()
        }
    }
    
    @IBAction func seePreviousMovies(_ sender: UIButton) {
        previousMovies[currentPage] = movies
        currentPage = currentPage - 1
        showPreviousMoviesButton(!isFirstPage())
        displayMoviesOnTableView()
    }
    
    //MARK: - API Calls
    func getGenres() {
        showActivityIndicator()
        GetGenres().execute(
            onSuccess: { (genres: Genres?) in
                self.genres = genres
                if self.movies == nil {
                    self.getUpcomingMovies(page: self.currentPage+1)
                }
        }, onError: { (error: Error) in
            self.hideActivityIndicator()
            print(error.localizedDescription)
        })
    }
    
    func getUpcomingMovies(page: Int) {
        GetUpcomingMovies(page: page).execute(
            onSuccess: { (upcomingMovies: UpcomingMovies?) in
                if let movies = upcomingMovies {
                    if let results = movies.results, results.count > 0 {
                        self.movies = movies
                        self.tableView.reloadData()
                        self.seeMoreMoviesButton.isHidden = false
                    } else {
                        Util.showMessageOnScreen(message: "There's no more upcoming movies to show.", controller: self)
                        self.seeMoreMoviesButton.isHidden = true
                    }
                }
                self.hideActivityIndicator()
        }, onError: { (error: Error) in
            self.hideActivityIndicator()
            print(error.localizedDescription)
        })
    }
    
    //MARK: - Changing View State
    func showPreviousMoviesButton(_ show: Bool) {
        previousMoviesButton.isHidden = !show
        upcomingMoviesLabel.isHidden = show
    }
    
    func displayMoviesOnTableView() {
        movies = previousMovies[currentPage]
        finishedLoadingInitialTableCells = false
        self.tableView.reloadData()
    }
    
    func isFirstPage() -> Bool {
        return currentPage == 0
    }
    
    func showActivityIndicator() {
        mainView.addSubview(activityIndicator)
        activityIndicator.frame = mainView.bounds
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

//MARK: - Get Genre
extension UpcomingMoviesViewController {
    
    func getGenre(_ currentMovie: Movie) -> String? {
        var firstGenre = true
        var genre = ""
        if let currentMovieGenre = currentMovie.genres, currentMovieGenre.count > 0 {
            for genreId in currentMovieGenre {
                if let genres = genres?.genres, genres.count > 0 {
                    for i in 0 ..< genres.count {
                        if genres[i].id == genreId {
                            genre = "\(genre)\(firstGenre ? "" : ", ")\(genres[i].name!)"
                            firstGenre = false
                        }
                    }
                }
            }
        }
        return genre
    }
    
}

//MARK: - Table View
extension UpcomingMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.results?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as? MovieTableViewCell  else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            }
        
        if let movie = movies {
            if let result = movie.results {
                
                let currentMovie = result[indexPath.row]
                let genre = getGenre(currentMovie)
                
                if let posterPath = currentMovie.posterPath {
                    let posterUrl = "\(Constants.TMDB_IMAGES)\(posterPath)"
                    cell.configure(poster: posterUrl, title: currentMovie.title, genre: genre, releaseDate: currentMovie.releaseDate)
                } else {
                    cell.configure(title: currentMovie.title, genre: genre, releaseDate: currentMovie.releaseDate)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var movieSelected : Movie?
        if let movie = movies {
            if let result = movie.results {
                 movieSelected = result[indexPath.row]
            }
        }
        
        guard let movie = movieSelected else { return }
        
        let movieViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailMovieViewController") as! DetailMovieViewController
        movieViewController.movieTitle = movie.title
        movieViewController.movieDescription = movie.overview
        movieViewController.genre = getGenre(movie)
        movieViewController.releaseDate = movie.releaseDate
        movieViewController.backgroundTopImagePath = movie.backdropPath
        
        self.present(movieViewController, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150;
    }
    
    //MARK: Display cell animation
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        var lastInitialDisplayableCell = false
        
        //change flag as soon as last displayable cell is being loaded (which will mean table has initially loaded)
        guard let moviesCount = movies?.results?.count else { return }
        if moviesCount > 0 && !finishedLoadingInitialTableCells {
            if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows,
                let lastIndexPath = indexPathsForVisibleRows.last, lastIndexPath.row == indexPath.row {
                lastInitialDisplayableCell = true
            }
        }
        
        if !finishedLoadingInitialTableCells {
            
            if lastInitialDisplayableCell {
                finishedLoadingInitialTableCells = true
            }
            
            //animates the cell as it is being displayed for the first time
            cell.transform = CGAffineTransform(translationX: 0, y: tableView.rowHeight/2)
            cell.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.05*Double(indexPath.row), options: [.curveEaseInOut], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
        }
    }
    
}

