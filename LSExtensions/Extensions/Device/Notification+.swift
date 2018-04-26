//
//  Notification+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 4. 25..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation
extension Notification{
    /**
     Frame of Keyboard
     */
    public var keyboardFrame : CGRect{
        var value = (self.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue;
        if value.height <= 0{
            value = (self.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        }
        
        return value;
    }
    
    /**
     Duration of Animation to appear Keyboard
     */
    public var keyboardAniDuration : TimeInterval{
        return userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval;
    }
}
