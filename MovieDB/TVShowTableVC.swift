//
//  TVShowTableVC.swift
//  MovieDB
//
//  Created by Brandon Baars on 8/1/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit
import AlamofireImage

class TVShowTableVC: UITableViewController {
    
    @IBOutlet weak var backdropPoster: UIImageView!
    @IBOutlet weak var posterPath: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var genre1Label: UILabel!
    @IBOutlet weak var genre2Label: UILabel!
    @IBOutlet weak var genre3Label: UILabel!
    @IBOutlet weak var seasonsLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var tvShow:TVShow!
    var header: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()
        
        header = backdropPoster
        backdropPoster.clipsToBounds = true
        tableView.tableHeaderView?.addSubview(header)
        tableView.tableHeaderView?.sendSubview(toBack: header)
    }
    
    // MARK: STICKY HEADER
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setNewView()
    }
    

    func setNewView() {
        
        var headerTransform = CATransform3DIdentity
        
        var headerFrame = CGRect(x: 0, y: -195, width: tableView.bounds.width, height: 195)
        
        if tableView.contentOffset.y < 0 {
            
            headerFrame.origin.y = tableView.contentOffset.y
            headerFrame.size.height = (-tableView.contentOffset.y) + 195
            header.frame = headerFrame
            
        }  else {
          
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-50, -tableView.contentOffset.y), 0)
        }
        
        header.layer.transform = headerTransform
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
        
        titleLabel.text = tvShow.name
        seasonsLabel.text = "Seasons: \(tvShow.numOfSeason)"
        episodesLabel.text = "Episodes: \(tvShow.numOfEpisodes)"
        overviewLabel.text = tvShow.overview
        
        
        genre1Label.isHidden = true
        genre2Label.isHidden = true
        genre3Label.isHidden = true
        
        if let url = URL(string: "\(imageUrlPrefix)w500/\(self.tvShow.backdropPath)") {
            self.backdropPoster.af_setImage(withURL: url)
        }
        
        if let url = URL(string: "\(imageUrlPrefix)w500/\(self.tvShow.posterPath)") {
            self.posterPath.af_setImage(withURL: url)
            //self.posterPath = self.addCornersAndDropShadow(image: self.posterPath, imgRadius: 10.0, radius: 5.0, offset: 2.0)
        }
        
        var count = 0
        for genre in self.tvShow.genres {
            if let name = genre["name"] as? String {
                if count == 0 {
                    genre1Label.isHidden = false
                    genre1Label.text = name
                    genre1Label.layer.borderWidth = 2.0
                    genre1Label.layer.borderColor = UIColor.lightGray.cgColor
                    genre1Label.layer.cornerRadius = 3.0
                } else if count == 2 {
                    genre2Label.isHidden = false
                    genre2Label.text = name
                    genre2Label.layer.borderWidth = 2.0
                    genre2Label.layer.borderColor = UIColor.lightGray.cgColor
                    genre2Label.layer.cornerRadius = 3.0
                } else if count == 3 {
                    genre3Label.isHidden = false
                    genre3Label.text = name
                    genre3Label.layer.borderWidth = 2.0
                    genre3Label.layer.borderColor = UIColor.lightGray.cgColor
                    genre3Label.layer.cornerRadius = 3.0
                }
                
                count += 1
            }
        }
        
        updateVoteImage()

    }
    
    func updateVoteImage() {
        
        /* finds the decimal of the number */
        let decimal = tvShow.voteAverage.truncatingRemainder(dividingBy: 1)
        var stars:Int = 0
        
        /* if the decimal is higher than 5, we round up */
        if decimal >= 0.5 {
            ceil(tvShow.voteAverage)
            stars = Int(ceil(tvShow.voteAverage) / 2)
        } else {
            stars = Int(tvShow.voteAverage / 2)
        }
        
        /* depending on the number of stars we set our image */
        if stars > 0 {
            ratingImage.image = UIImage(named: "\(stars)star")
        } else {
            ratingImage.image = UIImage(named: "empty")
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tvShow.cast.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ActorDetailCell", for: indexPath) as? MovieDetailCell {
            
            let actor = tvShow.cast[indexPath.row]
            cell.configureActorCell(actor: actor)
            
            return cell
        }

         

        return MovieCell()
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let actor = ActorDBManager()
        
        actor.downloadActorDetails(actorID: "\(tvShow.cast[indexPath.row].id)") {
   
            self.performSegue(withIdentifier: "toActorDetailVC", sender: actor.getActor())
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if let destination = segue.destination as? ActorDetailVC {
            if let actor = sender as? Actor {
                destination.actor = actor
            }
        }
    }

}
