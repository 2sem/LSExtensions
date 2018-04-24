//
//  UITextField+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2017. 1. 28..
//  Copyright © 2017년 leesam. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    @IBInspectable
    public var placeHolderColor : UIColor? {
        get{
            return self.placeHolderColor;
        }
        
        set(value){
            guard let color = value else{
                self.placeholder = self.attributedPlaceholder?.string;
                return;
            }
            
            let text = self.placeholder ?? self.attributedPlaceholder?.string;
            let attbText = NSAttributedString(string: text ?? "", attributes: [NSAttributedStringKey.foregroundColor : color]);
            self.attributedPlaceholder = attbText;
        }
    }
}
