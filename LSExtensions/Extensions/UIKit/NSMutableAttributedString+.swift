//
//  NSMutableAttributedString+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 8. 4..
//  Copyright © 2018년 leesam. All rights reserved.
//

import UIKit

extension NSMutableAttributedString{
    /**
         Appends new attributed string with given color and returns it.
         - parameter string: String to make attributed string with
         - parameter color: Color to make attributed string with
     */
    open func append(_ string: String, withColor color: UIColor) -> NSMutableAttributedString{
        self.append(NSMutableAttributedString.init(string: string, attributes: [.foregroundColor : color]))
        
        return self;
    }
    
    /**
         Appends new attributed string with given color.
         - parameter string: String to make attributed string with
         - parameter color: Color to make attributed string with
     */
    open func append(_ string: String, withAttributes attrs: [NSAttributedStringKey : Any]? = nil) -> NSMutableAttributedString{
        self.append(NSMutableAttributedString.init(string: string, attributes: attrs));
        
        return self;
    }
    
    /**
         Appends given attributed string and returns it.
         - parameter attrString: Attributed String to append trailing
     */
    open func appending(_ attrString: NSAttributedString) -> NSMutableAttributedString{
        self.append(attrString);
        
        return self;
    }
    
    /**
         Appends new attributed string created with given string and returns it.
         - parameter string: Attributed String to append trailing
     */
    open func appending(_ string: String) -> NSMutableAttributedString{
        return self.append(string);
    }
    
    /**
         Creates new attributed string with given string and color
         - parameter string: String to make attributed string with
         - parameter color: Color to make attributed string with
     */
    public convenience init(_ string : String, color: UIColor){
        self.init(string: string, attributes: [.foregroundColor : color]);
    }
}
