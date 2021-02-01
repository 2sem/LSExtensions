//
//  NSNotification.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 4. 17..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation
import UIKit

extension NSNotification{
    /**
         Frame of Keyboard - UIKeyboardFrameBeginUserInfoKey
     */
    public var keyboardFrame : CGRect{
        var value = (self.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue;
        if value.height <= 0{
            value = (self.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        }
        
        return value;
    }
    
    /**
     Duration of Animation to appear Keyboard
    */
    public var keyboardAniDuration : TimeInterval{
        return userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval;
    }
}
