//
//  ActorTableVC.swift
//  MovieDB
//
//  Created by Brandon Baars on 8/5/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit
import AlamofireImage

class ActorTableVC: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var segmentedControl: UnderlineSegmentedControl!
    @IBOutlet weak var headerImage: UIImageView!
    
    var actor: Actor!
    var isBio = true
    var isMovie = false
    var isTV = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        segmentedControl.addUnderline()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 127
    }
    
    //MARK: SEGUE
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        let segue = SegueFromLeft(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    
    /* needed for our unwind story board segue */
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset = tableView.contentOffset.y
        
        
        // PULL DOWN
        if offset < 0 {
            
            headerImage.frame.origin.y = offset
            headerImage.frame.size.height = -offset + 334
        }
    }
    
    
    func updateUI() {
        
        nameLabel.text = actor.name
        creditsLabel.text = "Know Credits: \(actor.movies.count)"
        birthdayLabel.text = "Birthday: \(actor.birthday)"
        placeOfBirthLabel.text = "Place of Birth: \(actor.placeOfBirth)"
        ///biographyDescription.text = actor.biography
        
        if let url = URL(string: "\(imageUrlPrefix)w500/\(actor.profilePath)") {
            self.profileImage.af_setImage(withURL: url)
        }
        
        profileImage.layer.cornerRadius = 10.0
        profileImage.clipsToBounds = true
        //self.profileImage = self.addCornersAndDropShadow(image: self.profileImage, imgRadius: 10.0, radius: 5.0, offset: 2.0)
    }
    
    
    /* Prefer our status bar to be hidden on our view */
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func segmentedControlDidChange(_ sender: Any) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            isBio = true
            isMovie = false
            isTV = false
        } else if segmentedControl.selectedSegmentIndex == 1 {
            isBio = false
            isMovie = true
            isTV = false
        } else if segmentedControl.selectedSegmentIndex == 2 {
            isBio = false
            isMovie = false
            isTV = true
        }
        
        if segmentedControl.selectedSegmentIndex == 0 {
            tableView.rowHeight = UITableViewAutomaticDimension
        } else {
            tableView.rowHeight = 127
        }
        
        print(tableView.rowHeight)
        
        segmentedControl.changeUnderlinePosition()
        tableView.setContentOffset(CGPoint.zero, animated: false)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isBio {
            return 1
        } else if isMovie {
            return actor.movies.count
        } else if isTV {
            return actor.tvShows.count
        }
        
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        if isBio {
            cell.configureCell(label: actor.biography)
        }
        else if isMovie {
            let movie = actor.movies[indexPath.row]
            cell.configureCell(movie: movie, row: indexPath.row)
        } else {
            cell.configureCell(tvshow: actor.tvShows[indexPath.row])
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movieDB = MovieDBManager()
        let tvDB = TVShowDBManager()
        
        if isMovie {
            
            movieDB.downloadMoreMovieDetails(url: "\(APIUrlPrefix)/movie/\(actor.movies[indexPath.row].id)?api_key=") {
                print(self.actor.movies[indexPath.row].title)
                self.performSegue(withIdentifier: "toMovieDetail", sender: movieDB.getMovie())
            }
        } else if isTV {
            
            tvDB.downloadTVShowDBDetails(id: actor.tvShows[indexPath.row].id, completed: {
                self.performSegue(withIdentifier: "toTVDetailVC", sender: tvDB.getTvShowDetails())
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toMovieDetail" {
            if let destination = segue.destination as? MovieDetailTableVC {
                if let movie = sender as? Movie {
                    destination.movie = movie
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
    


}
