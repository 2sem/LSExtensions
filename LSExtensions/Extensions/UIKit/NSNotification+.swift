//
//  NSNotification+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2021/02/01.
//  Copyright © 2021 leesam. All rights reserved.
//

import UIKit

extension NSNotification{
    var endKeyboardFrame : CGRect{
        let value = (self.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero;
        
        return value;
    }
}
