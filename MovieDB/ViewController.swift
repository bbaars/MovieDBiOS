//
//  ViewController.swift
//  MovieDB
//
//  Created by Brandon Baars on 6/28/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /* IB OUTLETS */
    @IBOutlet weak var menuView: UIViewX!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var popularTitle: UILabel!
    @IBOutlet weak var popularDescription: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    /* Our poster image */
    var posterImage: UIImage!
    
    /* Array of top movies */
    var topMovies: [Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadDetails()
        closeMenu()
        
        let img = UIImage(named: "notAvailable")
        self.image.image = img
        
        
    }
    
    func loadDetails() {
        
        let movie = MovieDBManager()
        
        
        movie.downloadMovieDBDetails(parameter: SearchTypes.popular) {
            
            self.topMovies = movie.getTopMovies()
            if let url = URL(string: "\(imageUrlPrefix)w500/\(self.topMovies[0].posterPath)") {
                self.image.af_setImage(withURL: url)
                self.popularTitle.text = self.topMovies[0].title
                self.popularDescription.text = self.topMovies[0].overview
                self.tableView.reloadData()
            }

            self.image = self.addCornersAndDropShadow(image: self.image, imgRadius: 10.0, radius: 5.0, offset: 2.0)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topMovies.count - 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row + 1 < topMovies.count {
            let movie = topMovies[indexPath.row + 1]
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell {
                cell.configureCell(movie: movie)
                return cell
            }
        }
        return MovieCell()
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

