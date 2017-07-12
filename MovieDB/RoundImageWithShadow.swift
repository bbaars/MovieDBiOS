//
//  RoundImageWithShadow.swift
//  MovieDB
//
//  Created by Brandon Baars on 7/8/17.
//  Copyright © 2017 Brandon Baars. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
    /*
     * Takes in a UIImageView as a parameter and addes a radius and drop shadow 
     * to the specified image and then returns it
     */
    func addCornersAndDropShadow(image: UIImageView, imgRadius: Double, radius: Double, offset: Double) -> UIImageView{
        
        let opacity: Float = 0.65
        
        let containerView: UIView = UIView()
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: offset, height: offset)
        containerView.layer.shadowOpacity = opacity
        containerView.layer.shadowRadius = CGFloat(radius)
        self.view.addSubview(containerView)
        
        image.layer.frame = containerView.bounds
        image.layer.cornerRadius = CGFloat(imgRadius)
        image.layer.masksToBounds = true
        containerView.addSubview(image)
        
        return image
    }
}
