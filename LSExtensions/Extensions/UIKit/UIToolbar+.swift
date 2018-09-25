//
//  UIToolbar+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 9. 24..
//  Copyright © 2018년 leesam. All rights reserved.
//

import UIKit

extension UIToolbar{
    /**
        Indicatior whether background of this toolbar is transparent or not
    */
    open var isTransparent : Bool{
        get{
            return self.backgroundColor == .clear;
        }
        set(value){
            guard value else{
                return;
            }
            
            self.backgroundColor = .clear;
            self.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default);
            self.setShadowImage(UIImage(), forToolbarPosition: .any);
        }
    }
}
