//
//  MovieCell.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/10/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UITableViewCell  {
    
    
    @IBOutlet weak var movieImage: UIImageViewX!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    
    
    func configureCell(movie: Movie) {
        
        biographyLabel.isHidden = true
        movieImage.isHidden = false
        movieTitle.isHidden = false
        movieDescription.isHidden = false
    
        /* no highlighting when the cell has been tapped */
        self.selectionStyle = .none
        
        /* obtains the url and sets the movie image */
        if let url = URL(string: "\(imageUrlPrefix)w500/\(movie.posterPath)") {
            self.movieImage.af_setImage(withURL: url)
        }
        
        /* sets the title and description of the movie */
        self.movieTitle.text = movie.title
        self.movieDescription.text = movie.overview
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        movieImage.image = nil
        movieTitle.text = ""
        movieDescription.text = ""
        biographyLabel.text = ""
    }
    
    func configureCell(label: String) {
        
        /* no highlighting when the cell has been tapped */
        self.selectionStyle = .none
        
        biographyLabel.isHidden = false
        movieImage.isHidden = true
        movieTitle.isHidden = true
        movieDescription.isHidden = true
        
        self.biographyLabel.text = label
        self.biographyLabel.numberOfLines = 0
    }
    
    
    func configureCell(actor: Actor) {
        
        biographyLabel.isHidden = true
        movieImage.isHidden = false
        movieTitle.isHidden = false
        movieDescription.isHidden = false
        
        /* no highlighting when the cell has been tapped */
        self.selectionStyle = .none
        
        /* obtains the url and sets the movie image */
        if let url = URL(string: "\(imageUrlPrefix)w500/\(actor.profilePath)") {
            self.movieImage.af_setImage(withURL: url)
        }
        
        
        movieTitle.text = actor.name
        movieDescription.text = actor.biography
        
        
    }
    
}
