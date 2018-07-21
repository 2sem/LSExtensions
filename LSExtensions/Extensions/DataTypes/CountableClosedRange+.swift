//
//  CountableClosedRange+.swift
//  siwonlectureroom
//
//  Created by 이영준 on 2018. 7. 18..
//  Copyright © 2018년 siwonschool. All rights reserved.
//

import Foundation

extension CountableClosedRange{
    /**
        short cut for .compactMap{ $0 }.random
    */
    public var random : Bound?{
        return self.compactMap{ $0 }.random;
    }
}
