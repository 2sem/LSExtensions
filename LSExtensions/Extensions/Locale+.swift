//
//  Locale+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 4. 21..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension Locale{
    /**
     Indication whether this is korean locale?
    */
    var isKorean : Bool{
       return self.identifier.hasPrefix("ko");
    }
}
