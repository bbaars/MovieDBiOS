//
//  MovieDetailCell.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/15/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit
import AlamofireImage


class MovieDetailCell: UITableViewCell {
    
    
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var actorImage: UIImageViewX!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    func configureInfoCell(movie: Movie) {
        
        /* no highlighting when the cell has been tapped */
        self.selectionStyle = .none
        
        actorImage.isHidden = true
        actorName.isHidden = true
        characterLabel.isHidden = true
        infoLabel.isHidden = false
        
        if movie.overview != "" {
             infoLabel.text = movie.overview
        } else {
            infoLabel.text = "Sorry, no overview exists"
        }
       
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        

        
        actorImage.image = nil
        actorName.text = ""
        infoLabel.text = ""
        characterLabel.text = ""
    }
    
    func configureActorCell(actor: Cast) {
        
        /* no highlighting when the cell has been tapped */
        self.selectionStyle = .none
        
        actorImage.isHidden = false
        actorName.isHidden = false
        infoLabel.isHidden = true
        characterLabel.isHidden = false
        
        self.actorImage.image = UIImage(named: "notAvailable")
        
        /* obtains the url and sets the movie image */
        if let url = URL(string: "\(imageUrlPrefix)w500/\(actor.profilePath)") {
            self.actorImage.af_setImage(withURL: url)
        }
        
        actorName.text = actor.name
        characterLabel.text = actor.character
    }
    
    func configureNonInfoCell(review: Review) {
        
        /* no highlighting when the cell has been tapped */
        self.selectionStyle = .none
        
        actorImage.isHidden = true
        actorName.isHidden = true
        infoLabel.isHidden = false
        characterLabel.isHidden = true
        infoLabel.text = "A Review By: \(review.author) \n" + review.content

    }
    
    func configureEmptyInfoCell() {
        
        /* no highlighting when the cell has been tapped */
        self.selectionStyle = .none
        
        actorImage.isHidden = true
        actorName.isHidden = true
        infoLabel.isHidden = false
        characterLabel.isHidden = true
        infoLabel.text = "There are no reviews at this time"
    }
}
