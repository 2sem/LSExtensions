//
//  CNContact+.swift
//  sendadv
//
//  Created by 영준 이 on 2017. 1. 31..
//  Copyright © 2017년 leesam. All rights reserved.
//

import UIKit
import Contacts

extension CNContact {
    public var fullName : String?{
        get{
            return CNContactFormatter.string(from: self, style: .fullName);
        }
    }
}
