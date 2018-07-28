//
//  UIDevice+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 7. 28..
//  Copyright © 2018년 leesam. All rights reserved.
//

import UIKit

extension UIDevice{
    ///Hidden property names
    class ValueKeys{
        static let orientation = "orientation";
    }
    
    /**
        Set orientation of this device forcely
        - parameter orientation: device orientation
    */
    func setOrientation(_ orientation: UIDeviceOrientation){
        self.setValue(orientation.rawValue.description, forKey: ValueKeys.orientation);
    }
    
    /**
         Set orientation of this device forcely
         - parameter byRaw: The Int value device orientation
     */
    func setOrientation(byRaw value: Int){
        guard let orientation = UIDeviceOrientation.init(rawValue: value) else{
            return;
        }
        
        self.setValue(orientation.rawValue.description, forKey: ValueKeys.orientation);
    }
}
