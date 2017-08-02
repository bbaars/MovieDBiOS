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
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    
    override func prepareForReuse() {
        
        resultLabel.text = ""
        resultsImage.image = nil
        typeLabel.text = ""
        characterLabel.text = ""
        
    }
    
    func configureCell(object: Any) {
        
        characterLabel.isHidden = true
        typeLabel.layer.borderWidth = 2.0
        typeLabel.layer.cornerRadius = 5.0
        typeLabel.clipsToBounds = true
        
        if object is Movie {
            
            /* obtains the url and sets the movie image */
            if let url = URL(string: "\(imageUrlPrefix)w500/\((object as! Movie).posterPath)") {
                self.resultsImage.af_setImage(withURL: url)
            }
            
            resultLabel.text = (object as! Movie).title
            
            typeLabel.text = "M"
            typeLabel.layer.borderColor = UIColor.init(red: 0/255, green: 211/255, blue: 115/255, alpha: 0.7).cgColor
            typeLabel.backgroundColor = UIColor.init(red: 0/255, green: 211/255, blue: 115/255, alpha: 0.7)
            
        } else if object is Actor {
            
            /* obtains the url and sets the movie image */
            if let url = URL(string: "\(imageUrlPrefix)w500/\((object as! Actor).profilePath)") {
                self.resultsImage.af_setImage(withURL: url)
            }
            
            typeLabel.text = "A"
            typeLabel.layer.borderColor = UIColor.init(red: 255/255, green: 128/255, blue: 128/255, alpha: 0.7).cgColor
            typeLabel.backgroundColor = UIColor.init(red: 255/255, green: 128/255, blue: 128/255, alpha: 0.7)

            
            resultLabel.text = (object as! Actor).name
            
        } else if object is Cast {
            
             characterLabel.isHidden = false
            
            /* obtains the url and sets the movie image */
            if let url = URL(string: "\(imageUrlPrefix)w500/\((object as! Cast).profilePath)") {
                self.resultsImage.af_setImage(withURL: url)
            }
            
            typeLabel.text = "A"
            typeLabel.layer.borderColor = UIColor.init(red: 255/255, green: 128/255, blue: 128/255, alpha: 0.7).cgColor
            typeLabel.backgroundColor = UIColor.init(red: 255/255, green: 128/255, blue: 128/255, alpha: 0.7)
            
            characterLabel.text = "\((object as! Cast).character)"
            resultLabel.text = (object as! Cast).name
            
        } else if object is TVShow {
            
            characterLabel.isHidden = true
            
            /* obtains the url and sets the movie image */
            if let url = URL(string: "\(imageUrlPrefix)w500/\((object as! TVShow).posterPath)") {
                self.resultsImage.af_setImage(withURL: url)
            }
            
            resultLabel.text = (object as! TVShow).name
            
            typeLabel.text = "TV"
            typeLabel.layer.borderColor = UIColor.init(red: 71/255, green: 121/255, blue: 255/255, alpha: 0.7).cgColor
            typeLabel.backgroundColor = UIColor.init(red: 71/255, green: 121/255, blue: 255/255, alpha: 0.7)
        }
    }
    
}
