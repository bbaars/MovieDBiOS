//
//  UnderlineSegmentedControl.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/12/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit

class UnderlineSegmentedControl: UISegmentedControl {

    func removeBorder() {
        
        /* setting the background color to white for all states of our UI Segmented Controller */
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        
        /* setting the Divider image to white as well, and changing the text color to Our green for selected and gray for normal */
        let dividerImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(dividerImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray], for: .normal)
        self.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 0/255, green: 211/255, blue: 115/255, alpha: 1.0)], for: .selected)
    }
    
    func addUnderline() {
        self.removeBorder()
        
        /* create our underline by width, Height, X and Y Positions */
        let underlineWidth = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underlineXPos = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underlineYPos = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPos, y: underlineYPos, width: underlineWidth, height: underlineHeight)
        
        /* add the underlineFrame to our underline view */
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor(red: 0/255, green: 211/255, blue: 115/255, alpha: 1.0)
        underline.tag = 1
        self.addSubview(underline)
    }
    
    func changeUnderlinePosition() {
        
        guard let underline = self.viewWithTag(1) else {return}
        
        let underlineFinalXPos = (self.bounds.width) / CGFloat(self.numberOfSegments) * CGFloat(selectedSegmentIndex)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            underline.frame.origin.x = underlineFinalXPos
        })
    }
}

extension UIImage {
    
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return rectangleImage!
    }
}
