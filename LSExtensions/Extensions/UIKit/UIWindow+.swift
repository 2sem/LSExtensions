//
//  Window+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 4. 27..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow{
    /**
     Preload Keyboard when first keyboard appears, it can be slow or little stucked 
    */
    public func preloadKeyboard() -> Void{
        let tempText = UITextField();
        self.addSubview(tempText);
        tempText.becomeFirstResponder();
        tempText.resignFirstResponder();
        tempText.removeFromSuperview();
    }
}
