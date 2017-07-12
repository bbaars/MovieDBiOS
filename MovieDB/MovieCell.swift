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
    
    
    func configureCell(movie: Movie) {
        
        print(movie.posterPath)
        print(movie.title)
        print(movie.overview)
        
        self.selectionStyle = .none
        
        if let url = URL(string: "\(imageUrlPrefix)w500/\(movie.posterPath)") {
            self.movieImage.af_setImage(withURL: url)
        }
        
        self.movieTitle.text = movie.title
        self.movieDescription.text = movie.overview
    }
    

}
