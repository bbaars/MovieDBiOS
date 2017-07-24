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
    
    
    /* Our poster image */
    var posterImage: UIImage!
    
    /* Array of Extra Movie Details */
    var movieDetails: [Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestureRecognizer()

        tableView.dataSource = self
        tableView.delegate = self
        menuCurveImageView.image = #imageLiteral(resourceName: "MenuCurve")
        loadDetails()
        let img = UIImage(named: "notAvailable")
        self.image.image = img
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        hideMenu()
        closeMenu()
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
        let movie = movieDetails[0]
        performSegue(withIdentifier: "toMovieDetailVC", sender: movie)
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        let segue = SegueFromLeft(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    
    func loadDetails() {
        
        let movie = MovieDBManager()
        let actor = ActorDBManager()
        
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
        
        actor.downloadActorDetails(actorID: "500") { 
            
            print("Completed Actor Download")
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
        return movieDetails.count - 1
    }
    
    
    /* Configures the table to display popular  movies, top rated movies, and actors */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row + 1 < movieDetails.count {
            let movie = movieDetails[indexPath.row + 1]
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell {
                cell.configureCell(movie: movie)
                return cell
            }
        }
        return MovieCell()
    }
    
    
    /* Used to see which row the user clicks on. When they click on it, we obtain that movie info 
        and prepare to segue */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row + 1 < movieDetails.count {
            let movie = movieDetails[indexPath.row + 1]
            
            performSegue(withIdentifier: "toMovieDetailVC", sender: movie)
        }
    }
    
    /* When we click on a table row, we will send that information to our Detail VC */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailVC {
            if let movie = sender as? Movie {
                destination.movie = movie
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

