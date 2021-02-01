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
    
    /// Moves content in this scroll view to center to keep center content
    open func moveToCenter(){
        let contentWidth = self.contentSize.width;
        let x = self.bounds.width - contentWidth;
        
        let contentHeight = self.contentSize.height;
        let y = self.bounds.height - contentHeight;
        
        guard x > 0 || y > 0 else{
            self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
            return;
        }
        
        self.contentInset = UIEdgeInsets(top: y / 2, left: x / 2, bottom: 0, right: 0);
        print("[\(#function)]set scrollView content offset[\(x / 2), \(y / 2)] inset[\(self.contentInset)]");
    }
    
    /// Scroll to top(offset 0))
    open func scrollToTop(){
        self.setContentOffset(.init(x: 0, y: self.contentInset.top), animated: true);
    }
    
    /// Scroll to bottom(offset content height - height)
    open func scrollToBottom(){
        self.setContentOffset(.init(x: 0, y: self.contentSize.height - self.frame.height + self.contentInset.bottom), animated: true);
    }
}
