//
//  AccountDetailTableVC.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/28/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit

struct StretchyHeader {
    let headerHeight: CGFloat = 150.0
}

class AccountDetailTableVC: UITableViewController {

    var favoriteMovies = [Movie]()
    var watchList = [Movie]()
    var headerView: UIView!
    var newHeaderLayer: CAShapeLayer!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    var isWatchList: Bool = true
       
    @IBOutlet weak var segmentControl: UnderlineSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        segmentControl.addUnderline()
        addGestureRecognizer()
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setNewView()
        
        // Get the vertical offset of our tableview
        //var offset = tableView.contentOffset.y
        //var headerTransform = CATransform3DIdentity
    }
    
    func addGestureRecognizer() {
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
    }
    
    func swipeAction(swipe: UISwipeGestureRecognizer) {
        
        if swipe.direction == .left {
            if isWatchList {
                segmentControl.selectedSegmentIndex = 1
                segmentControl.changeUnderlinePosition()
                tableView.setContentOffset(CGPoint(x: 0, y: -StretchyHeader().headerHeight), animated: false)
                tableView.reloadData()
                isWatchList = false

            }
        } else if swipe.direction == .right {
          
            if !isWatchList {
                isWatchList = true
                segmentControl.selectedSegmentIndex = 0
                segmentControl.changeUnderlinePosition()
                tableView.setContentOffset(CGPoint(x: 0, y: -StretchyHeader().headerHeight), animated: false)
                tableView.reloadData()
            }
        }
    }
    
    
    func updateView() {
        
        tableView.backgroundColor = UIColor.white
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(headerView)
        
        let newHeight = StretchyHeader().headerHeight
        tableView.contentInset = UIEdgeInsets(top: newHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newHeight)
        setNewView()
    }
    
    func setNewView() {
        
        let newHeight = StretchyHeader().headerHeight
        var getHeaderFrame = CGRect(x: 0, y: -newHeight, width: tableView.bounds.width, height: StretchyHeader().headerHeight)
        
        if tableView.contentOffset.y < -newHeight {
            getHeaderFrame.origin.y = tableView.contentOffset.y
            getHeaderFrame.size.height = -tableView.contentOffset.y
          
//            var getLabelFrame = CGRect(x: welcomeLabel.frame.origin.x, y: welcomeLabel.frame.origin.y, width: welcomeLabel.frame.width, height: welcomeLabel.frame.height)
//            getLabelFrame.origin.y = tableView.contentOffset.y
//            getLabelFrame.size.height = -tableView.contentOffset.y
//            welcomeLabel.frame = getLabelFrame
//            
        }
        
        headerView.frame = getHeaderFrame
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func segmentedControlDidChange(_ sender: Any) {
        segmentControl.changeUnderlinePosition()
        
        if segmentControl.selectedSegmentIndex == 1 {
            isWatchList = false
        } else {
            isWatchList = true
        }
        
        tableView.reloadData()
        
    }
  
    //MARK: SEGUE
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        let segue = SegueFromLeft(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    
    /* needed for our unwind story board segue */
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? MovieDetailVC {
            if let movie = sender as? Movie {
                destination.movie = movie
            }
        }
    }
}


extension AccountDetailTableVC {
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isWatchList {
            return watchList.count
        }
        
        return favoriteMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        if isWatchList {
            cell.configureCell(movie: watchList[indexPath.row])
        } else {
             cell.configureCell(movie: favoriteMovies[indexPath.row])
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedMovie: Movie?
        let movieDB = MovieDBManager()
        
        
        if isWatchList && watchList.count != 0 {
            selectedMovie = watchList[indexPath.row]
        } else if favoriteMovies.count != 0 {
            selectedMovie = favoriteMovies[indexPath.row]
        }
        
        if let movie = selectedMovie {
            movieDB.downloadMoreMovieDetails(url: "\(APIUrlPrefix)/movie/\(movie.id)?api_key=") {
                self.performSegue(withIdentifier: "toMovieDetailVC", sender: movieDB.getMovie())
            }
        }
    }
}
