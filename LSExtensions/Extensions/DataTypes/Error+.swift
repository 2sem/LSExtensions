//
//  Error+.swift
//  pallyconswiftdemo
//
//  Created by 영준 이 on 2018. 6. 27..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension Error{
    /**
        Returns code of NSError converted from this
    */
    public var code : Int{
        return (self as NSError).code;
    }
}
