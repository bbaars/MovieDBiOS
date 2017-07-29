//
//  ActorDetailVC.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/25/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit
import AlamofireImage

class ActorDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var segmentedControl: UnderlineSegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
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
    
    
    func updateUI() {
        
        nameLabel.text = actor.name
        creditsLabel.text = "Know Credits: \(actor.movies.count)"
        birthdayLabel.text = "Birthday: \(actor.birthday)"
        placeOfBirthLabel.text = "Place of Birth: \(actor.placeOfBirth)"
        ///biographyDescription.text = actor.biography
        
        if let url = URL(string: "\(imageUrlPrefix)w500/\(actor.profilePath)") {
            self.profileImage.af_setImage(withURL: url)
        }
        
        self.profileImage = self.addCornersAndDropShadow(image: self.profileImage, imgRadius: 10.0, radius: 5.0, offset: 2.0)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isBio {
            return 1
        } else if isMovie {
            return actor.movies.count
        } else if isTV {
            return 1
        }
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = actor.movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        if isBio {
            cell.configureCell(label: actor.biography)
        }
        else if isMovie {
            cell.configureCell(movie: movie)
        } else {
            cell.configureCell(label: "Sorry, not available at this time")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movieDB = MovieDBManager()
        
        if isMovie {
            
            movieDB.downloadMoreMovieDetails(url: "\(APIUrlPrefix)/movie/\(actor.movies[indexPath.row].id)?api_key=") {
                self.performSegue(withIdentifier: "toMovieDetail", sender: movieDB.getMovie())
            }

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? MovieDetailVC {
            if let movie = sender as? Movie {
                destination.movie = movie
            }
        }
    }
    
}
