//
//  TempCell.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/27/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit

class TempCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!

    
    func configureCell(movie: String) {
    
        movieTitle.text = movie
    }
}
