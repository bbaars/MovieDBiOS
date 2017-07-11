//
//  SlideFromRight.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/10/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import Foundation
import UIKit

class SegueFromRight: UIStoryboardSegue {
    
    override func perform() {

        /* Set our source view controller and our destination view controller */
        let src = self.source.view as UIView!
        let dst = self.destination.view as UIView!
        
        /* obtain the screen width and height */
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
       /* set our frame for our source to be where we currently are at */
        src?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        /* we place our destination view controller to the right of our screen */
        dst?.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        
        /* get the current app windown and add our destination to it */
        let appWindow = UIApplication.shared.keyWindow
        appWindow?.insertSubview(dst!, aboveSubview: src!)

        /* we animate our view in 0.3s and curve ease into view */
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            
            src?.frame = (src?.frame.offsetBy(dx: -screenWidth, dy: 0))!
            dst?.frame = (dst?.frame.offsetBy(dx: -screenWidth, dy: 0))!
        }) { (Bool) in
            self.source.present(self.destination, animated: false, completion: nil)
        }
    }
}
