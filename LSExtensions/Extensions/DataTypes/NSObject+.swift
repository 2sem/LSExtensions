//
//  NSObject+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 5. 3..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension NSObject{
    public var lastClassName : String{
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? "";
    }
}
