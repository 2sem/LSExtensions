//
//  NSObject+.swift
//  pallyconswiftdemo
//
//  Created by 영준 이 on 2018. 6. 28..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension NSObject{
    // MARK: Sets observer
    /**
         Wrapper for addObserval
         Registers observation - receive by observeValue(...)
         - parameter observer: observer to receive observation reporting
         - parameter key: The property name of AVAudioSession to observe
     */
    public func addObserver<T: RawRepresentable>(_ observer: NSObject, keyType: T.Type, key: T, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?) where T.RawValue == String{
        self.addObserver(observer, forKeyPath: key.rawValue, options: options, context: context);
    }
    
    /**
         Wrapper for addObserval
         Unregisters observation - receive by observeValue(...)
         - parameter observer: observer receiving observation reporting
         - parameter key: The property name of AVAudioSession to stop observing
     */
    public func removeObserver<T: RawRepresentable>(_ observer: NSObject, keyType: T.Type, key: T, context: UnsafeMutableRawPointer?)  where T.RawValue == String{
        self.removeObserver(observer, forKeyPath: key.rawValue, context: context);
    }
    
    // MARK: Sets associated object
    /**
        Wrapper for objc_getAssociatedObject();
        - parameter key: key for associated object
    */
    public func objcProperty(_ key: UnsafeRawPointer) -> Any?{
        return objc_getAssociatedObject(self, key);
    }
    
    /**
        Wrapper for objc_setAssociatedObject()
        - parameter key: key for associated object
        - parameter value: value for associated object
        - parameter policy: Release policy for associated object
     */
    public func setObjcProperty(_ key: UnsafeRawPointer, value: Any?, policy: objc_AssociationPolicy) -> Void{
        objc_setAssociatedObject(self, key, value, policy);
    }
    
    public var lastClassName : String{
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? "";
    }
    
    static func ifNil<T>(_ original: T?, value: T) -> T{
        return (original == nil) ? value : original!;
    }
}
