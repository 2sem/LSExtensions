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
    /**
         Alias for the Full name of this contact
     */
    public var fullName : String?{
        get{
            return CNContactFormatter.string(from: self, style: .fullName);
        }
    }
    
    /**
         Alias for the phonetic(easy to pronounce?) Full name of this contact
     */
    public var phoneticFullName : String?{
        get{
            return CNContactFormatter.string(from: self, style: .phoneticFullName);
        }
    }
}
