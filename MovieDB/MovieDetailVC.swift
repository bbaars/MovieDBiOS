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
    
    var movie: Movie!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        addGestureRecognizer()
        
        if let url = URL(string: "\(imageUrlPrefix)w500/\(self.movie.posterPath)") {
            self.movieImage.af_setImage(withURL: url)
        }
        
        self.movieImage = self.addCornersAndDropShadow(image: self.movieImage, imgRadius: 10.0, radius: 5.0, offset: 2.0)
        self.movieTitle.text = self.movie.title
        self.taglineLabel.text = self.movie.tagline
        runTimeLabel.text = movie.runtimeToString()
        webView.loadHTMLString("<div style=\"position:relative;height:0;padding-bottom:56.25%\"><iframe src=\"https://www.youtube.com/embed/\(movie.movieTrailer)?ecver=2\" width=\"640\" height=\"360\" frameborder=\"0\" style=\"position:absolute;width:100%;height:100%;left:0\"></iframe></div>", baseURL: nil)
        
        print("POPULARITY \(movie.popularity)")

        
    }
    
    /* Adds the gesture recognizer to our view for us to return */
    func addGestureRecognizer() {
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
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
}
