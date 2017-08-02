//
//  MovieDetailHeaderView.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/27/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit

class MovieDetailHeaderView: UIView {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var image: UIImage? {
        didSet {
            if let image = image {
                imageView.image = image
            } else {
                imageView.image = nil
            }
        }
    }
}
