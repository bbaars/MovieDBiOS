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
    
    var movie: Movie!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        addGestureRecognizer()
        
        segmentedControl.addUnderline()
        
        if let url = URL(string: "\(imageUrlPrefix)w500/\(self.movie.posterPath)") {
            self.movieImage.af_setImage(withURL: url)
        }
        
        self.movieImage = self.addCornersAndDropShadow(image: self.movieImage, imgRadius: 10.0, radius: 5.0, offset: 2.0)
        self.movieTitle.text = self.movie.title
        self.taglineLabel.text = self.movie.tagline
        runTimeLabel.text = movie.runtimeToString()
        webView.loadHTMLString("<div style=\"position:relative;height:0;padding-bottom:56.25%\"><iframe width=\"430\" height=\"208\" src=\"https://www.youtube.com/embed/\(movie.movieTrailer)?rel=0&showinfo=0&autohide=1\" frameborder=\"0\" allowfullscreen></iframe></div>", baseURL: nil)
    
    }
    
    func swipeAction(swipe: UISwipeGestureRecognizer) {
        
        var index = segmentedControl.selectedSegmentIndex
        
        if index != 0 && swipe.direction == .left {
            index -= 1
            segmentedControl.selectedSegmentIndex = index
            segmentedControl.changeUnderlinePosition()
        }
        
        if index != 2 && swipe.direction == .right {
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



















