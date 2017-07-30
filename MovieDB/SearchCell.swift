//
//  SearchCell.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/30/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit
import AlamofireImage


class SearchCell: UITableViewCell {
    
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultsImage: UIImageViewX!
    
    func configureCell(object: Any) {
        
        if object is Movie {
            
            /* obtains the url and sets the movie image */
            if let url = URL(string: "\(imageUrlPrefix)w500/\((object as! Movie).posterPath)") {
                self.resultsImage.af_setImage(withURL: url)
            }
            
            resultLabel.text = (object as! Movie).title
            
        } else if object is Actor {
            
            /* obtains the url and sets the movie image */
            if let url = URL(string: "\(imageUrlPrefix)w500/\((object as! Actor).profilePath)") {
                self.resultsImage.af_setImage(withURL: url)
            }
            
            resultLabel.text = (object as! Actor).name
        }
    }
    
}
