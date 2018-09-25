//
//  UIColor+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 9. 24..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation
extension UIColor{
    /**
        Create color with red, green, blue, opacity(alpha)
        - parameter r: red to make color with
        - parameter g: green to make color with
        - parameter b: blue to make color with
        - parameter opacity: opacity(alpha) of the color
    */
    public convenience init(r: Int, g: Int, b: Int, opacity : Float = 1.0){
        let r = Int.limit(r, max: 255);
        let g = Int.limit(g, max: 255);
        let b = Int.limit(b, max: 255);
        let a = Float.limit(opacity, max: 255.0);
        
        self.init(red: CGFloat(Float(r)/255.0), green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a));
    }
}
