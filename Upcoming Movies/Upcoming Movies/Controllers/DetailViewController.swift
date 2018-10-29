//
//  DetailViewController.swift
//  Upcoming Movies
//
//  Created by Mac-Mini on 29/10/18.
//  Copyright © 2018 Mac-Mini. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        
//        GetMovieDetail(movieId: "76341").execute(
//            onSuccess: { (movie: Movie) in
//                print(movie)
//        }, onError: { (error: Error) in
//            print(error.localizedDescription)
//        })
//
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }
}

