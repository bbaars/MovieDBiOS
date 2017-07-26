//
//  ActorDetailVC.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/25/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit

class ActorDetailVC: UIViewController {
    
    var actor: Actor!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(actor.name)
    }

    /* Prefer our status bar to be hidden on our view */
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
