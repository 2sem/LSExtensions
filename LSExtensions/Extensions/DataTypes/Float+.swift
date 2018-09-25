//
//  Float+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 9. 24..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension Float{
    /**
        returns max value if the value is larger than max
        - parameter value: default value
        - parameter max: max value to limit
    */
    public static func limit(_ value : Float, max: Float) -> Float{
        return value < max ? value : max;
    }
}
