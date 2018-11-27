//
//  Comparable+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 11. 27..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension Comparable{
    /**
     returns max value if the value is larger than max
     - parameter value: default value
     - parameter max: max value to limit
     */
    public func limit(min: Self, max: Self) -> Self{
        return self < min ? min : self.limit(max: max);
    }
    
    /**
     returns max value if the value is larger than max
     - parameter value: default value
     - parameter max: max value to limit
     */
    public func limit(max: Self) -> Self{
        return self < max ? self : max;
    }
    
    /**
     returns min value if the value is larger than max
     - parameter value: default value
     - parameter min: min value to limit
     */
    public func limit(min: Self) -> Self{
        return self > min ? self : min;
    }
}
