//
//  CMTime+.swift
//  ShowNote
//
//  Created by 영준 이 on 2016. 1. 18..
//  Copyright © 2016년 leesam. All rights reserved.
//

import UIKit
import AVFoundation

extension CMTime {
    /**
        Returns string with the date generated this value as Seconds
        - Parameters:
            - format: String format to print date as String
            - locale: Locale to use date formmating
    */
    public func dateString(_ format : String = "HH:mm:ss", withoutZeroHour : Bool = false, formatForZeroHour : String = "mm:ss") -> String{
        let seconds = CMTimeGetSeconds(self);
        guard seconds >= 60 * 60 else{
            return seconds.dateString(formatForZeroHour);
        }
        
        return seconds.dateString(format);
        /*var value = "";
         
         let date = NSDate(timeIntervalSince1970: CMTimeGetSeconds(self));
         let formatter = NSDateFormatter();
         formatter.timeZone = NSTimeZone(name: "UTC");
         formatter.dateFormat = format;
         
         value = formatter.stringFromDate(date);
         
         return value;*/
    }
    
    /**
        Seconds converted from this time
    */
    /*public var seconds : Double{
        get{
            return CMTimeGetSeconds(self);
        }
    }*/
    
    /**
        Checks if this time is valid
        Wrapper for CMTIME_IS_VALID()
        - returns: Indication whether if this time is valid
    */
    public static func isValid(_ time: CMTime) -> Bool{
        return CMTIME_IS_VALID(time);
    }
    
    /**
         Create new CMTime added given time to this time
         Wrapper for CMTimeAdd()
         - parameter time: The time to add to this time
         - returns: New CMTime added given additional time to this time
    */
    public func add(_ time: CMTime) -> CMTime{
        return CMTimeAdd(self, time);
    }
    
    /**
         Create new CMTime subtracted given time from this time
         Wrapper for CMTimeSubtract()
         - parameter time: The time to subtract from this time
         - returns: New CMTime subtracted given time from this time
     */
    public func subtract(_ time: CMTime) -> CMTime{
        return CMTimeSubtract(self, time);
    }
}
