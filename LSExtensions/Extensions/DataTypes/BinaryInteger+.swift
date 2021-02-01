//
//  BinaryInteger+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2021/02/01.
//  Copyright © 2021 leesam. All rights reserved.
//

import Foundation

extension BinaryInteger{
    @inlinable public mutating func advancing(by n: Int){
        self = self.advanced(by: n);
    }
}
