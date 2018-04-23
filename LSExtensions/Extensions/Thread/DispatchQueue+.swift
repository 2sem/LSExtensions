//
//  DispatchQueue+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2017. 7. 28..
//  Copyright © 2017년 leesam. All rights reserved.
//

import Foundation
import UIKit

extension DispatchQueue{
    /**
     Excute block in Main Thread synchronously
    */
    public func syncInMain(execute block: () -> Swift.Void){
        if Thread.isMainThread{
            block();
        }else{
            self.sync(execute: block);
        }
    }
}
