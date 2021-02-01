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
    public var textField : UITextField?{
        get{
            if #available(iOS 13, *){
                return self.searchTextField;
            }else{
                return self.children(type: UITextField.self).first;
            }
        }
    }
    
    /**
         gets UIImageView contained in UITextField of this UISearchBar
     */
    public var searchTextFieldBackground : UIImageView?{
        get{
            return self.textField?.children(type: UIImageView.self).first;
        }
    }
    
    @IBInspectable
    public var textColor : UIColor?{
        get{
            return self.textField?.textColor;
        }
        set(value){
            self.textField?.textColor = value;
        }
    }
    
    @IBInspectable
    public var placeHolderColor : UIColor?{
        get{
            var value : UIColor? = .gray;
            guard self.textField?.attributedPlaceholder != nil else{
                return value;
            }
            
            var range = NSRange.init(location: 0, length: 1);
            value = self.textField?.attributedPlaceholder?.attribute(NSAttributedString.Key.foregroundColor, at: 0, effectiveRange: &range) as? UIColor;
            
            return value;
        }
        set(value){
            self.textField?.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: value ?? UIColor.lightText]);
        }
    }
}
