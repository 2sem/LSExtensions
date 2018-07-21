//
//  AVURLAsset+.swift
//  pallyconswiftdemo
//
//  Created by 영준 이 on 2018. 6. 25..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation
import AVFoundation

extension AVURLAsset{
    /**
         Observation keys
     */
    public enum ObserveKey: String{
        case tracks = "tracks"
        case playable = "playable"
    }
    
    /**
         Proxy for registerObserver
         Registers observation - receive by observeValue(...)
         - parameter observer: observer to receive observation reporting
         - parameter key: The property name of AVAudioSession to observe
     */
    public func registerObserver(_ observer: NSObject, key: ObserveKey, options: NSKeyValueObservingOptions = [.new, .initial], context: UnsafeMutableRawPointer? = nil){
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
    }
}
