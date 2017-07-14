//
//  MovieDetailVC.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/11/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var popularityImage: UIImageView!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UnderlineSegmentedControl!
    @IBOutlet weak var genreLabel1: UILabel!
    @IBOutlet weak var genreLabel2: UILabel!
    @IBOutlet weak var genreLabel3: UILabel!
    
    
    var movie: Movie!
    var vote: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestureRecognizer()
        segmentedControl.addUnderline()
        setupUI()
    }
    
    func setupUI() {
        
        genreLabel1.isHidden = true
        genreLabel2.isHidden = true
        genreLabel3.isHidden = true
        
        if let url = URL(string: "\(imageUrlPrefix)w500/\(self.movie.posterPath)") {
            self.movieImage.af_setImage(withURL: url)
        }
        
        var count = 0
        for genre in self.movie.genre {
            if let name = genre["name"] as? String {
                if count == 0 {
                    genreLabel1.isHidden = false
                    genreLabel1.text = name
                    genreLabel1.layer.borderWidth = 2.0
                    genreLabel1.layer.borderColor = UIColor.lightGray.cgColor
                    genreLabel1.layer.cornerRadius = 3.0
                } else if count == 2 {
                    genreLabel2.isHidden = false
                    genreLabel2.text = name
                    genreLabel2.layer.borderWidth = 2.0
                    genreLabel2.layer.borderColor = UIColor.lightGray.cgColor
                    genreLabel2.layer.cornerRadius = 3.0
                } else if count == 3 {
                    genreLabel3.isHidden = false
                    genreLabel3.text = name
                    genreLabel3.layer.borderWidth = 2.0
                    genreLabel3.layer.borderColor = UIColor.lightGray.cgColor
                    genreLabel3.layer.cornerRadius = 3.0
                }
                
                count += 1
            }
        }
        self.movieImage = self.addCornersAndDropShadow(image: self.movieImage, imgRadius: 10.0, radius: 5.0, offset: 2.0)
        self.movieTitle.text = self.movie.title
        self.taglineLabel.text = self.movie.tagline
        runTimeLabel.text = movie.runtimeToString()
        webView.loadHTMLString("<div style=\"position:relative;height:0;padding-bottom:56.25%\"><iframe width=\"430\" height=\"208\" src=\"https://www.youtube.com/embed/\(movie.movieTrailer)?rel=0&showinfo=0&autohide=1\" frameborder=\"0\" allowfullscreen></iframe></div>", baseURL: nil)
        updateVoteImage()
    }
    
    func updateVoteImage() {
        
        /* finds the decimal of the number */
        let decimal = movie.voteAverage.truncatingRemainder(dividingBy: 1)
        var stars:Int = 0
        
        /* if the decimal is higher than 5, we round up */
        if decimal >= 0.5 {
            ceil(movie.voteAverage)
            stars = Int(ceil(movie.voteAverage) / 2)
        } else {
             stars = Int(movie.voteAverage / 2)
        }

        /* depending on the number of stars we set our image */
        if stars > 0 {
            popularityImage.image = UIImage(named: "\(stars)star")
        } else {
            popularityImage.image = UIImage(named: "empty")
        }
    }
    
    func swipeAction(swipe: UISwipeGestureRecognizer) {
        
        var index = segmentedControl.selectedSegmentIndex
        
        if index != 0 && swipe.direction == .right {
            index -= 1
            segmentedControl.selectedSegmentIndex = index
            segmentedControl.changeUnderlinePosition()
        }
        
        if index != 2 && swipe.direction == .left {
            index += 1
            segmentedControl.selectedSegmentIndex = index
            segmentedControl.changeUnderlinePosition()
        }
    }
    
    /* Adds the gesture recognizer to our view for us to return */
    func addGestureRecognizer() {
        
        /* add gesture recognizer to go back to previous View Controller */
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
        
        /* Add gestures to swipe through the different tables */
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)

    }
    
    /* remove the status bar from the view */
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /* our selector action for the gesture recognizer */
    func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        
        if recognizer.state == .recognized {
            performSegue(withIdentifier: "backSegue", sender: nil)
        }
    }
    @IBAction func segmentedControlDidChange(_ sender: Any) {
        
        segmentedControl.changeUnderlinePosition()
    }
}



















