//
//  NSError+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 5. 1..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension NSError{
    public var isAssistantError : Bool{
        return self.domain == "kAFAssistantErrorDomain";
    }
    
    public var siriError : NSError?{
        var value : NSError?;
        if self.isAssistantError{
            if let siriError = self.userInfo["NSUnderlyingError"] as? NSError, siriError.domain.hasPrefix("Siri"){
                value = siriError;
            }
        }
        
        return value;
    }
    
    public var isSiriConnectionError : Bool{
        var value = false;
        
        //        print("[\(#function)] error main \(self.domain)");
        if self.domain == "SiriCoreSiriConnectionErrorDomain"{
            value = true;
        }
        else if let siriError = self.siriError {
            //            print("[\(#function)] error siri \(siriError.domain)");
            value = (siriError.domain == "SiriCoreSiriConnectionErrorDomain");
        }
        
        return value;
    }
}
