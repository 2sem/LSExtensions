//
//  URL+.swift
//  pallyconswiftdemo
//
//  Created by 영준 이 on 2018. 6. 29..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension URL{
    /**
        Indicator whether this is web url or not
         True: web url, otherwise is not
    */
    public var isWebURL : Bool{
        return ["http", "https"].contains(self.scheme?.lowercased() ?? "");
    }
}
