//
//  UIScrollView+.swift
//  siwonlectureroom
//
//  Created by 이영준 on 2018. 7. 16..
//  Copyright © 2018년 siwonschool. All rights reserved.
//

import UIKit

extension UIScrollView{
    /**
        Scrolls to given textField to make it visible
        - parameter textField: The text field destination to scroll
        - parameter animated: Whether animating the scrolling
    */
    public func scroll(ifEmpty textField: UITextField, animated: Bool = true) -> Bool{
        var value = false;
        guard textField.text?.isEmpty ?? false else {
            return value;
        }
        
        self.scrollRectToVisible(textField.convert(textField.bounds, to: self), animated: animated);
        value = true;
        
        return value;
    }
    
    /**
        You should check if contentSize is zero before call this method
    */
    public func scroll(to view: UIView, animated: Bool = true){
        let rect = view.convert(view.bounds, to: self);
        
        self.scrollRectToVisible(rect, animated: animated);
    }
    
    /**
         Height of this
         Alias of frame.height
     */
    public var height : CGFloat{
        return self.frame.height;
    }
}
