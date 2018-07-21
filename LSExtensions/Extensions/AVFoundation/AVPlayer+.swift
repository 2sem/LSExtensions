//
//  AVPlayer+.swift
//  pallyconswiftdemo
//
//  Created by 영준 이 on 2018. 6. 25..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation
import AVFoundation
import CoreMedia

extension AVPlayer{
    /**
         Observation keys
     */
    public enum ObserveKey: String{
        case status = "status";
        case rate = "rate";
        case currentItem = "currentItem";
    }
    
    /**
         Proxy for registerObserver
         Registers observation - receive by observeValue(...)
         - parameter observer: observer to receive observation reporting
         - parameter key: The property name of AVAudioSession to observe
     */
    public func registerObserver(_ observer: NSObject, key: ObserveKey, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer? = nil){
        self.addObserver(observer, keyType: ObserveKey.self, key: key, options: options, context: context);
        //self.addObserver(observer, forKeyPath: key.rawValue, options: .new, context: nil);
    }
    
    /**
         Proxy for unregisterObserver
         Unregisters observation - receive by observeValue(...)
         - parameter observer: observer receiving observation reporting
         - parameter key: The property name of AVAudioSession to stop observing
     */
    public func unregisterObserver(_ observer: NSObject, key: ObserveKey, context: UnsafeMutableRawPointer? = nil){
        self.removeObserver(observer, keyType: ObserveKey.self, key: key, context: context);
        //self.removeObserver(observer, forKeyPath: key.rawValue);
    }
    
    /**
        Seeks backward of track with given unit and limitation
        - parameter unit: Unit of the seeking
        - parameter minimum: Minimum position of track to limit the seeking
        - parameter maximum: Maximum position of track to limit the seeking
    */
    public func seekBackward(_ unit: CMTime, minimum: CMTime = CMTime.zero, maximum: CMTime = CMTime.zero){
        self.seek(to: self.currentTime().subtract(unit), toleranceBefore: minimum, toleranceAfter: maximum);
    }
    
    /**
         Seeks forward of track with given unit and limitation
         - parameter unit: Unit of the seeking
         - parameter minimum: Minimum position of track to limit the seeking
         - parameter maximum: Maximum position of track to limit the seeking
     */
    public func seekForward(_ unit: CMTime, minimum: CMTime = CMTime.zero, maximum: CMTime = CMTime.zero){
        self.seek(to: self.currentTime().add(unit), toleranceBefore: minimum, toleranceAfter: maximum);
    }
}
