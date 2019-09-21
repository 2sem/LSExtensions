//
//  UISearchBar+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2019. 3. 11..
//  Copyright © 2019년 leesam. All rights reserved.
//

import UIKit

extension UISearchBar{
    /**
        gets UITextField contained in this UISearchBar
    */
    /*public var searchTextField : UITextField?{
        get{
            return self.children(type: UITextField.self).first;
        }
    }*/
    
    /**
         gets UIImageView contained in UITextField of this UISearchBar
     */
    public var searchTextFieldBackground : UIImageView?{
        get{
            return self.searchTextField.children(type: UIImageView.self).first;
        }
    }
    
    @IBInspectable
    public var textColor : UIColor?{
        get{
            return self.searchTextField.textColor;
        }
        set(value){
            self.searchTextField.textColor = value;
        }
    }
    
    @IBInspectable
    public var placeHolderColor : UIColor?{
        get{
            var value : UIColor? = .gray;
            guard self.searchTextField.attributedPlaceholder != nil else{
                return value;
            }
            
            var range = NSRange.init(location: 0, length: 1);
            value = self.searchTextField.attributedPlaceholder?.attribute(NSAttributedStringKey.foregroundColor, at: 0, effectiveRange: &range) as? UIColor;
            
            return value;
        }
        set(value){
            self.searchTextField.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor: value ?? UIColor.lightText]);
        }
    }
}
