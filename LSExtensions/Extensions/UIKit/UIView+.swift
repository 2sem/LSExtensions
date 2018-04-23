//
//  UIView+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2017. 6. 29..
//  Copyright © 2017년 leesam. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    /**
        Get UIViewController contains this UIView
     */
    var viewController : UIViewController?{
        get{
            var value : UIViewController?;
            
            //get upper responder if this doesn't response?
            guard let next = self.next else{
                return value;
            }
            
            if next is UIViewController{
                value = next as? UIViewController;
                return value;
            } else{
                //go to upper view if the upper responder is not UIViewController
                value = (next as? UIView)?.viewController;
            }
            
            return value;
        }
    }
}
