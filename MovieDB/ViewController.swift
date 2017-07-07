//
//  ViewController.swift
//  MovieDB
//
//  Created by Brandon Baars on 6/28/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIViewX!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let movie = MovieDB(url: "discover/movie?sort_by=popularity.desc")
        movie.downloadMovieDBDetails {
            
            print("completed")
        }
        
        /* CGAFFINE : preserve parallel relationships
         1, 1 leaves it the same size. */
        menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
    }
    
    @IBAction func menuTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.menuView.transform == .identity {
                self.menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            } else {
                self.menuView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        })
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

