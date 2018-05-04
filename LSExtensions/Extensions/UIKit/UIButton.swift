//
//  UIButton.swift
//  WhoCallMe
//
//  Created by 영준 이 on 2016. 4. 14..
//  Copyright © 2016년 leesam. All rights reserved.
//

import UIKit

extension UIButton{
    /**
        Fit image of this button as aspec scale
    */
    var imageAspectFit : Bool{
        get{
            var value = false;
            guard self.imageView != nil else{
                return value;
            }
            
            value = self.imageView!.contentMode == .scaleAspectFit;
            return value;
        }
        set(value){
            if value{
                self.imageView?.contentMode = .scaleAspectFit;
            }
        }
    }
    
    /**
        Align title to center
    */
    var titleCenter : Bool{
        get{
            return true;
        }
        
        set(value){
            if value{
                self.imageView?.isHidden = false;
                self.titleLabel?.isHidden = false;
                
                self.layoutIfNeeded();
            }
        }
    }
}
