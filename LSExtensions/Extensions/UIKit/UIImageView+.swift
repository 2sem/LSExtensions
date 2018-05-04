//
//  UIImageView.swift
//  WhoCallMe
//
//  Created by 영준 이 on 2016. 3. 26..
//  Copyright © 2016년 leesam. All rights reserved.
//

import UIKit

extension UIImageView {
    var useTemplateMode : Bool{
        get{
            return true;
        }
        set(value){
            if value{
                self.image = self.image?.withRenderingMode(.alwaysTemplate);
            }
        }
    }
}
