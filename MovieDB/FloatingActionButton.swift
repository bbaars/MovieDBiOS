//
//  FloatingActionButton.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/7/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit

class FloatingActionButton: UIButtonX {
    
    /*
    * When the user clicks on the button the 'begin tracking' function is called. Similar
    * to the touch up inside
    */
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        
        UIView.animate(withDuration: 0.3, animations: {
            
            /* animate the rotation of the button
             .identity = default value (how the transform starts ( no transform ) */
            if self.transform == .identity {
                self.transform = CGAffineTransform(rotationAngle: (.pi/4))
                self.backgroundColor = UIColor(red: 0/255, green: 128/255, blue: 70/255, alpha: 0.7)
            } else {
                self.transform = .identity
                self.backgroundColor = UIColor(red: 18/255, green: 215/255, blue: 135/255, alpha: 1)
            }
        })
        
        
        return super.beginTracking(touch, with: event)
    }
}
