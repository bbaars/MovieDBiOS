//
//  ViewController.swift
//  MovieDB
//
//  Created by Brandon Baars on 6/28/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIViewX!
    @IBOutlet weak var image: UIImageView!
    
    var posterImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let movie = MovieDB()

        
        let url = URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")!
        image.af_setImage(withURL: url)
        
        
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
        
        /* CGAFFINE : preserve parallel relationships -> 1, 1 leaves it the same size. */
        self.menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

