//
//  UIAlertController+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 7. 28..
//  Copyright © 2018년 leesam. All rights reserved.
//

import UIKit

extension UIAlertController{
    class HiddenPropertyNames{
        static let contentViewController = "contentViewController";
    }
    
    /**
        content for alert controller
    */
    var contentViewController : UIViewController?{
        get{
            return self.value(forKey: HiddenPropertyNames.contentViewController) as? UIViewController;
        }
        set(value){
            self.setValue(value, forKey: HiddenPropertyNames.contentViewController);
        }
    }
}
