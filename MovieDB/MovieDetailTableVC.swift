//
//  MovieDetailTableVC.swift
//  MovieDB
//
//  Created by Brandon Baars on 8/5/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit

class MovieDetailTableVC: UITableViewController {

    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var popularityImage: UIImageView!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var segmentedControl: UnderlineSegmentedControl!
    @IBOutlet weak var genreLabel1: UILabel!
    @IBOutlet weak var genreLabel2: UILabel!
    @IBOutlet weak var genreLabel3: UILabel!
    @IBOutlet weak var menu: UIViewX!
    
    
    var movie: Movie!
    var vote: Int = 0
    var isInfo = true
    var isCast = false
    var isReview = false
    var actors: [Actor] = [Actor]()
    
    /*
     * Override our view to update the UI, add the gesture recogizer and change our segmented control
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestureRecognizer()
        segmentedControl.addUnderline()
        setupUI()
        
        closeMenu()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = tableView.contentOffset.y
        
        
        if offset < 0 {
            
            webView.frame.origin.y = offset
            webView.frame.size.height = -offset + 200
            
        }
        
    }
    
    
    
    //MARK: SEGUE
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        let segue = SegueFromLeft(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    
    /* needed for our unwind story board segue */
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    //MARK: END OF SEGUE
    
    
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
        
        if self.movie.releaseDate != "" {
            let array = self.movie.releaseDate.components(separatedBy: "-")
            self.movieTitle.text = "\(movie.title) (\(array[0]))"
        } else {
            self.movieTitle.text = self.movie.title
        }
        
        self.movieImage.layer.cornerRadius = 10.0
        self.movieImage.clipsToBounds = true
        //self.movieImage = self.addCornersAndDropShadow(image: self.movieImage, imgRadius: 10.0, radius: 5.0, offset: 2.0)
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
        
        if index > 0 && swipe.direction == .right {
            index -= 1
            segmentedControl.selectedSegmentIndex = index
        }
        
        if index < 2 && swipe.direction == .left {
            index += 1
            segmentedControl.selectedSegmentIndex = index
        }
        
        updateTableData()
        segmentedControl.changeUnderlinePosition()
        tableView.setContentOffset(CGPoint.zero, animated: false)
        tableView.reloadData()
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
        
        updateTableData()
        segmentedControl.changeUnderlinePosition()
        tableView.setContentOffset(CGPoint.zero, animated: false)
        tableView.reloadData()
    }
    
    
    func updateTableData() {
        
        if segmentedControl.selectedSegmentIndex == 1 {
            tableView.rowHeight = 140
        } else {
            tableView.rowHeight = UITableViewAutomaticDimension
        }
        
        if segmentedControl.selectedSegmentIndex == 0 {
            isInfo = true
            isCast = false
            isReview = false
        }else if segmentedControl.selectedSegmentIndex == 1 {
            isInfo = false
            isCast = true
            isReview = false
        } else if segmentedControl.selectedSegmentIndex == 2 {
            isInfo = false
            isCast = false
            isReview = true
        }
    }
    
    /* finds how many rows in section we need based on our sizes */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /* finds how many rows in section we need based on our sizes */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            return 1
        }
        
        if segmentedControl.selectedSegmentIndex == 1 {
            
            if movie.cast.count <= 40 {
                return movie.cast.count
            } else {
                return 40
            }
        }
        
        if segmentedControl.selectedSegmentIndex == 2 {
            
            if movie.reviews.count == 0 {
                return 1
            }
            return movie.reviews.count
        }
        
        return 0
    }
    
    /* Configures the table to display popular  movies, top rated movies, and actors */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetailCell", for: indexPath) as? MovieDetailCell {
            
            if isInfo {
                cell.configureInfoCell(movie: movie)
            }
            if isCast {
                let actor = movie.cast[indexPath.row]
                cell.configureActorCell(actor: actor)
            }
            if isReview {
                if movie.reviews.count > 0 {
                    let review = movie.reviews[indexPath.row]
                    cell.configureNonInfoCell(review: review)
                } else {
                    cell.configureEmptyInfoCell()
                }
            }
            
            return cell
        }
        
        return MovieDetailCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let chosenActor = actors[indexPath.row]
        
        let actor = ActorDBManager()
        
        actor.downloadActorDetails(actorID: "\(movie.cast[indexPath.row].id)") {
            
            if self.isCast {
                self.performSegue(withIdentifier: "toActorDetailVC", sender: actor.getActor())
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ActorTableVC {
            if let actor = sender as? Actor {
                destination.actor = actor
            }
        }
    }
    
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3) {
            
            if self.menu.transform == .identity {
                self.closeMenu()
            } else {
                self.menu.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    func closeMenu() {
        menu.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        
        let account = AccountDBManager()
        
        account.addMovieToFavorites(id: self.movie.id, isFavorite: true) {
            self.closeMenu()
        }
        
    }
    
    
    @IBAction func watchListButtonPressed(_ sender: Any) {
        
        let account = AccountDBManager()
        
        account.addMovieToWatchList(id: self.movie.id, isWatchlist: true) {
            self.closeMenu()
        }
        
    }
}