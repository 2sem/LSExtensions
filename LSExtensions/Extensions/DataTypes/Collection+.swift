//
//  Collection+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 10. 21..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
