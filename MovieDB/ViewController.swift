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
        
        /* perform the code when the loading of the movies has completed */
        movie.downloadMovieDBDetails {
            
            print("completed")
        }
        
        /* CGAFFINE : preserve parallel relationships
         1, 1 leaves it the same size. */
        closeMenu()
    }
    
    /* When the + button is tapped in the bottom right hand corner of our First VC */
    @IBAction func menuTapped(_ sender: Any) {
        
        /* When the menu button is tapped, animate the UIView of our menu to full scale and back down */
        UIView.animate(withDuration: 0.3, animations: {
            if self.menuView.transform == .identity {
                self.closeMenu()
            } else {
                self.menuView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        })
    }
    
    func closeMenu() {
        self.menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

