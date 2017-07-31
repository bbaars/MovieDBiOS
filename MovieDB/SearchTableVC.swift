//
//  SearchTableVC.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/30/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit

class SearchTableVC: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var searchMultiButton: UIButton!
    
    var results = [Any]()
    var headerView: UIView!
    let headerHeight:CGFloat = 93.0
    var isMultiSearch: Bool = false
    var movieFilters = [String]()
    var actorFilters = [String]()
    var filteredResults = [Any]()
    var numFilters = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        searchMultiButton.isHidden = true
        
        searchBar.returnKeyType = .search
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let textField = searchBar.value(forKey: "searchField") as! UITextField
        textField.textColor = UIColor.white
        updateView()
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        setNewView()
    }
    
    func updateView() {
        
        tableView.backgroundColor = UIColor.white
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(headerView)
        
        let newHeight = headerHeight
        tableView.contentInset = UIEdgeInsets(top: newHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -newHeight)
        setNewView()
    }
    
    func setNewView() {
        
        let newHeight = headerHeight
        var getHeaderFrame = CGRect(x: 0, y: -newHeight, width: tableView.bounds.width, height: headerHeight)
        
        if tableView.contentOffset.y < -newHeight {
            getHeaderFrame.origin.y = tableView.contentOffset.y
            getHeaderFrame.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = getHeaderFrame
    }
    
    @IBAction func searchMultiButtonClicked(_ sender: Any) {
        
        let search = SearchDBManager()
        view.endEditing(true)
        
        if actorFilters.count > 1 {
            search.searchForMultipleActors(query: actorFilters) {
                self.results.removeAll()
                self.results = search.getSearchResult()
                self.tableView.reloadData()
            }
        } else {
            resultsLabel.text = "Try filtering by only actors"
        }
    }
    

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchCell {
            
            cell.configureCell(object: results[indexPath.row])
            
            return cell
        }
        
        
        return SearchCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let actorDB = ActorDBManager()
        let movieDB = MovieDBManager()
        
        if results[indexPath.row] is Movie {
            let movie = results[indexPath.row] as! Movie
            
            movieDB.downloadMoreMovieDetails(url: "\(APIUrlPrefix)/movie/\(movie.id)?api_key=") {
                self.performSegue(withIdentifier: "toMovieDetailVC", sender: movieDB.getMovie())
            }
        } else if results[indexPath.row] is Actor {
            
            if let actor = results[indexPath.row] as? Actor {
                actorDB.downloadActorDetails(actorID: "\(actor.id)") {
                    
                    self.performSegue(withIdentifier: "toActorDetailVC", sender: actorDB.getActor())
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let addAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: " Add  ") { (action, indexPath) in
            self.isEditing = true
            print("Add Button Pressed")
            
            self.numFilters += 1
            
            if self.numFilters >= 2 {
                self.searchMultiButton.isHidden = false
            }
           
           let obj = self.results[indexPath.row]
            self.isMultiSearch = true
        
            
            if obj is Movie {
                self.movieFilters.append("\((obj as! Movie).id)")
                print("Movie ID: \((obj as! Movie).id)")
                self.resultsLabel.text! += "\((obj as! Movie).title), "
            } else if obj is Actor {
                self.actorFilters.append("\((obj as! Actor).id)")
                self.resultsLabel.text! += "\((obj as! Actor).name), "
                print("Actor ID: \((obj as! Actor).id)")
            }
            
            self.searchBar.text! = ""
            self.isEditing = false
           
        }
        
        addAction.backgroundColor = UIColor.init(red: 22/255, green: 35/255, blue: 59/255, alpha: 1.0)
        
        return [addAction]
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toMovieDetailVC" {
            if let destination = segue.destination as? MovieDetailVC {
                if let movie = sender as? Movie {
                    destination.movie = movie
                }
            }
        } else if segue.identifier == "toActorDetailVC" {
            if let destination = segue.destination as? ActorDetailVC {
                if let actor = sender as? Actor {
                    destination.actor = actor
                }
            }
        }
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
        
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == "" || searchBar.text == nil {
            searchBar.endEditing(true)
            self.results.removeAll()
            self.tableView.reloadData()
            
        } else {
            
            let searchString = searchBar.text?.replacingOccurrences(of: " ", with: "%20")
            let search = SearchDBManager()
            search.searchDatabase(query: searchString!) {
                
                self.results = search.getSearchResult()
                self.tableView.reloadData()
                
            }
        }
    }
    
    //MARK: SEGUE
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        let segue = SegueFromLeft(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }
    
    /* needed for our unwind story board segue */
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    //MARK: END OF SEGUE
    
}
