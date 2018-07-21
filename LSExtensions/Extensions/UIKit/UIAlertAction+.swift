//
//  UIAlertAction+.swift
//  pallyconswiftdemo
//
//  Created by 영준 이 on 2018. 6. 27..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertAction{
    /**
        Generates UIAlertAction with default style
    */
    public static func `default`(_ title: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction{
        //case `default`
        return UIAlertAction.init(title: title, style: .default, handler: handler);
    }
    
    /**
         Generates UIAlertAction with cancel style
     */
    public static func cancel(_ title: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction{
        //case case
        return UIAlertAction.init(title: title, style: .cancel, handler: handler);
    }
    
    /**
         Generates UIAlertAction with destructive style
     */
    public static func destructive(_ title: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertAction{
        //case destructive
        return UIAlertAction.init(title: title, style: .destructive, handler: handler);
    }
}
