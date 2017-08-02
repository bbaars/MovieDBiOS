//
//  ViewController.swift
//  MovieDB
//
//  Created by Brandon Baars on 6/28/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /* IB OUTLETS */
    @IBOutlet weak var menuView: UIViewX!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var popularTitle: UILabel!
    @IBOutlet weak var popularDescription: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var screenCoverButton: UIButton!
    @IBOutlet weak var menuCurveImageView: UIImageView!
    @IBOutlet weak var menuLogo: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var filterLabel: UILabel!
    
    
    /* Our poster image */
    var posterImage: UIImage!
    
    /* Array of Extra Movie Details */
    var movieDetails: [Movie] = [Movie]()
    var topRatedMovies: [Movie] = [Movie]()
    var topActors: [Actor] = [Actor]()
    var favMovies: [Movie] = [Movie]()
    var watchList: [Movie] = [Movie]()
    var topTVShows: [TVShow] = [TVShow]()
    
    // filtering buttons are pushed
    var isPopular = true
    var isTopRated = false
    var isActor = false
    var isTV = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestureRecognizer()
        loadDetails()
        tableView.dataSource = self
        tableView.delegate = self
        let img = UIImage(named: "notAvailable")
        self.image.image = img
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        hideMenu()
        closeMenu()
        loadUserDetails()
    }
    
    func addGestureRecognizer() {
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
        
    }
    
    func swipeAction(swipe: UISwipeGestureRecognizer) {
        if swipe.state == .recognized {
            showMenu();
        }
    }
    
    
    /* needed for our unwind story board segue */
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    
    /* If the user taps on the Top Movie */
    @IBAction func moreButtonTapped(_ sender: Any) {
        
        if isPopular {
            let movie = movieDetails[0]
            performSegue(withIdentifier: "toMovieDetailVC", sender: movie)
        } else if isTopRated {
            let movie = topRatedMovies[0]
            performSegue(withIdentifier: "toMovieDetailVC", sender: movie)
        } else if isActor {
            let actor = topActors[0]
            
            let actorDB = ActorDBManager()
            
            actorDB.downloadActorDetails(actorID: "\(actor.id)") {
                self.performSegue(withIdentifier: "toActorDetailVC", sender: actorDB.getActor())
                
            }
        } else if isTV {
            
            let tv = topTVShows[0]
            
            let tvdb = TVShowDBManager()
            
            tvdb.downloadTVShowDBDetails(id: tv.id, completed: {
                
                self.performSegue(withIdentifier: "toTVDetailVC", sender: tvdb.getTvShowDetails())
            })
        }
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        let segue = SegueFromLeft(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    
    func loadDetails() {
        
        let movie = MovieDBManager()
       
        
        /* once we download the movie details we can update our UI and reload our Table Data */
        movie.downloadMovieDBDetails(parameter: SearchTypes.popular) {
            
            self.movieDetails = movie.getMovieDetails()
            if let url = URL(string: "\(imageUrlPrefix)w500/\(self.movieDetails[0].posterPath)") {
                self.image.af_setImage(withURL: url)
                self.popularTitle.text = self.movieDetails[0].title
                self.popularDescription.text = self.movieDetails[0].overview
                self.tableView.reloadData()
            }
            
            /* adds a corner radius and drop shadow to our image */
            //self.image = self.addCornersAndDropShadow(image: self.image, imgRadius: 10.0, radius: 5.0, offset: 2.0)
        }
        

    }
    
    func loadUserDetails() {
        
        let account = AccountDBManager()
        
        account.downloadWatchList {
            self.watchList = account.getWatchList()
        }
        
        account.downloadFavoriteMovies {
            self.favMovies = account.getFavoriteMovies()
        }
    }
    
    
    /* Prefer our status bar to be hidden on our view */
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /* Only displaying 1 section in the table view */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /* finds how many rows in section we need based on our sizes */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isPopular {
            return movieDetails.count - 1
        } else if isTopRated {
            return topRatedMovies.count - 1
        } else if isActor {
            return topActors.count - 1
        } else if isTV {
            return topTVShows.count - 1
        }
        
        return 1
    }
    
    
    /* Configures the table to display popular  movies, top rated movies, and actors */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
       
        
        if isPopular {
            if indexPath.row + 1 < movieDetails.count {
                let movie = movieDetails[indexPath.row + 1]
                cell.configureCell(movie: movie)
                return cell
            }
        } else if isTopRated {
            if indexPath.row + 1 < topRatedMovies.count {
                let movie = topRatedMovies[indexPath.row + 1]
                cell.configureCell(movie: movie)
                return cell
            }
        } else if isActor {
            if indexPath.row + 1 < topActors.count {
                let actor = topActors[indexPath.row + 1]
                cell.configureCell(actor: actor)
                return cell
            }
        } else if isTV {
            if indexPath.row + 1 < topTVShows.count {
                let tv = topTVShows[indexPath.row + 1]
                cell.configureCell(tvshow: tv)
                return cell
            }
        }
        
        return MovieCell()
    }
    
    //MARK: - NAVIGATION
    
    
    /* Used to see which row the user clicks on. When they click on it, we obtain that movie info 
        and prepare to segue */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isPopular {
            if indexPath.row + 1 < movieDetails.count {
                let movie = movieDetails[indexPath.row + 1]
                performSegue(withIdentifier: "toMovieDetailVC", sender: movie)
            }
        } else if isTopRated {
            if indexPath.row + 1 < topRatedMovies.count {
                let movie = topRatedMovies[indexPath.row + 1]
                performSegue(withIdentifier: "toMovieDetailVC", sender: movie)
            }
        } else if isActor {
            if indexPath.row + 1 < topActors.count {
                let actor = topActors[indexPath.row + 1]
                
                let actorDB = ActorDBManager()
                
                actorDB.downloadActorDetails(actorID: "\(actor.id)") {
                self.performSegue(withIdentifier: "toActorDetailVC", sender: actorDB.getActor())

                }
            }
        } else if isTV {
            
            if indexPath.row + 1 < topTVShows.count {
                
                let tv = topTVShows[indexPath.row + 1]
                
                let tvdb = TVShowDBManager()
                
                tvdb.downloadTVShowDBDetails(id: tv.id, completed: { 
                    
                    self.performSegue(withIdentifier: "toTVDetailVC", sender: tvdb.getTvShowDetails())
                })
            }
            
        }
    }
    
    /* When we click on a table row, we will send that information to our Detail VC */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAccountVC" {
            if let destination = segue.destination as? AccountDetailTableVC {
                if let favMovies = sender as? [Movie] {
                    destination.favoriteMovies = favMovies
                    destination.watchList = watchList
                }
            }
        } else if segue.identifier == "toMovieDetailVC" {
            if let destination = segue.destination as? MovieDetailVC {
                if let movie = sender as? Movie {
                    destination.movie = movie
                }
            }
        } else if segue.identifier == "toActorDetailVC" {
            if let destination = segue.destination as? ActorDetailVC {
                if let actor = sender as? Actor {
                    destination.actor = actor
                }
            }
        } else if segue.identifier == "toTVDetailVC" {
            if let destination = segue.destination as? TVShowTableVC {
                if let show = sender as? TVShow {
                    destination.tvShow = show
                }
            }
        }
    }
    
    
    /* When the + button is tapped in the bottom right hand corner of our First VC */
    @IBAction func menuTapped(_ sender: Any) {
        
        /* When the menu button is tapped, animate the UIView of our menu to full scale and back down */
        UIView.animate(withDuration: 0.3, animations: {
            if self.menuView.transform == .identity {
                self.closeMenu()
            } else {
                self.menuView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        })
    }
    
    
    func closeMenu() {
        
        /* CGAFFINE : preserve parallel relationships -> 1, 1 leaves it the same size. */
        self.menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        showMenu();
    }
    
    
    @IBAction func screenCoverButtonTapped(_ sender: Any) {
        hideMenu();
    }
    
    
    @IBAction func accountButtonTapped(_ sender: Any) {
         performSegue(withIdentifier: "toAccountVC", sender: favMovies)
    }
    
    @IBAction func topRatedButtonTapped(_ sender: Any) {
        
        let movie = MovieDBManager()
        
        isPopular = false
        isTopRated = true
        isActor = false
        isTV = false
        filterLabel.text = "Top Rated Movies"
        
        movie.downloadMovieDBDetails(parameter: SearchTypes.topRated) {
            print("Completed top rated Movies")
            self.topRatedMovies = movie.getMovieDetails()
            
            if let url = URL(string: "\(imageUrlPrefix)w500/\(self.topRatedMovies[0].posterPath)") {
                self.image.af_setImage(withURL: url)
                self.popularTitle.text = self.topRatedMovies[0].title
                self.popularDescription.text = self.topRatedMovies[0].overview
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func popularMovieButtonTapped(_ sender: Any) {
        isPopular = true
        isTopRated = false
        isActor = false
        isTV = false
        filterLabel.text = "Popular Movies"
    
        if let url = URL(string: "\(imageUrlPrefix)w500/\(self.movieDetails[0].posterPath)") {
            self.image.af_setImage(withURL: url)
            self.popularTitle.text = self.movieDetails[0].title
            self.popularDescription.text = self.movieDetails[0].overview
            self.tableView.reloadData()
        }
    }
    
    @IBAction func topRatedActorsButtonTapped(_ sender: Any) {
        isPopular = false
        isTopRated = false
        isActor = true
        isTV = false
        filterLabel.text = "Top Rated Actors"
        
        let actor = ActorDBManager()
        
        actor.downloadActorDetails(actorID: "popular") {
            
            self.topActors = actor.getActors()
            
            if let url = URL(string: "\(imageUrlPrefix)w500/\(self.topActors[0].profilePath)") {
                self.image.af_setImage(withURL: url)
                self.popularTitle.text = self.topActors[0].name
                self.popularDescription.text = self.topActors[0].biography
                self.tableView.reloadData()
            }
        }
    }
    
   
    @IBAction func topTVShowButtonPressed(_ sender: Any) {
        isPopular = false
        isTopRated = false
        isActor = false
        isTV = true
        
        filterLabel.text = "Popular TV Shows"
        
        let tv = TVShowDBManager()
        
        tv.downloadPopularTVShows {
            
            self.topTVShows = tv.getPopularTVShowDetails()
            
            if let url = URL(string: "\(imageUrlPrefix)w500/\(self.topTVShows[0].posterPath)") {
                self.image.af_setImage(withURL: url)
                self.popularTitle.text = self.topTVShows[0].name
                self.popularDescription.text = self.topTVShows[0].overview
                self.tableView.reloadData()
            }
        }
    }
    
    
    func showMenu() {
        
        sideMenuView.isHidden = false
        
        UIView.animate(withDuration: 0.4) {
            self.screenCoverButton.alpha = 1
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.06, options: .curveEaseOut, animations: {
            self.menuCurveImageView.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.settingButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.06, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.twitterButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.12, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.accountButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.18, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.homeButton.transform = .identity
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.24, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.menuLogo.transform = .identity
        })
    }
    
    func hideMenu() {
        
        UIView.animate(withDuration: 0.4) {
            self.screenCoverButton.alpha = 0
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.menuLogo.transform = CGAffineTransform(translationX: -self.menuView.frame.width - 100, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.08, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.homeButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width - 100, y: 0)
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.18, options: .curveEaseOut, animations: {
            self.menuCurveImageView.transform = CGAffineTransform(translationX: -self.menuCurveImageView.frame.width - 100, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.16, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.accountButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width - 100, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.21, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.twitterButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width - 100, y: 0)
        })
        
        UIView.animate(withDuration: 0.4, delay: 0.25, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.settingButton.transform = CGAffineTransform(translationX: -self.menuView.frame.width - 100, y: 0)
        }) { success in
            self.sideMenuView.isHidden = true
        }
    
    }
}

