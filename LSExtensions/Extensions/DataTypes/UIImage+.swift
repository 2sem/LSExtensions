//
//  UIImage+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2016. 12. 27..
//  Copyright © 2016년 leesam. All rights reserved.
//

import UIKit

extension UIImage {
    /**
        Returns new image redrawed with given size and background color
        - parameter size: size of new image
        - parameter backgroundColor: background color of new image
        - returns: new image redrawed with given size and background color
    */
    public func image(withSize size : CGSize, backgroundColor : UIColor? = nil) -> UIImage{
        var value = self;
        
        UIGraphicsBeginImageContext(size);
        let ctx = UIGraphicsGetCurrentContext();
        
        let rect = CGRect(origin: CGPoint.zero, size: size);
        //fill with background color if it was specified
        if let color = backgroundColor{
            ctx!.setFillColor(color.cgColor);
            ctx!.fill(rect);
        }
        
        //redraw image with given size
        self.draw(in: rect);
        
        value = UIGraphicsGetImageFromCurrentImageContext()!;
        
        UIGraphicsEndImageContext();
        
        return value;
    }
}
