//
//  UITableView+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 8. 4..
//  Copyright © 2018년 leesam. All rights reserved.
//

import UIKit

extension UITableView{
    /**
     Hides the line for the empty rows
     */
    public var hideExtraRows : Bool{
        get{
            return self.tableFooterView != nil;
        }
        set(value){
            self.tableFooterView = value ? UIView() : nil;
        }
    }
}
