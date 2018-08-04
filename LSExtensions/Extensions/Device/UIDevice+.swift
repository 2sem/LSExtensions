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
    public func setOrientation(_ orientation: UIDeviceOrientation){
        self.setValue(orientation.rawValue.description, forKey: ValueKeys.orientation);
    }
    
    /**
         Set orientation of this device forcely
         - parameter byRaw: The Int value device orientation
     */
    public func setOrientation(byRaw value: Int){
        guard let orientation = UIDeviceOrientation.init(rawValue: value) else{
            return;
        }
        
        self.setValue(orientation.rawValue.description, forKey: ValueKeys.orientation);
    }
    
    /**
         Total Disk Size
         - reference : https://stackoverflow.com/questions/26198073/query-available-ios-disk-space-with-swift
     */
    public static var totalCapacity: Int64? {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let value = (systemAttributes[.systemSize] as? NSNumber)?.int64Value else {
                return nil
        }
        
        return value;
    }
    
    /**
         Free Disk Size remained
     */
    public static var availableCapacity: Int64? {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let value = (systemAttributes[.systemFreeSize] as? NSNumber)?.int64Value else {
                return nil
        }
        
        return value;
    }
}
