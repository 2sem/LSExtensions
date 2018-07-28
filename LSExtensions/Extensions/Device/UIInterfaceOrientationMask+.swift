//
//  UIInterfaceOrientationMask+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 7. 28..
//  Copyright © 2018년 leesam. All rights reserved.
//

import UIKit

extension UIInterfaceOrientationMask{
    /**
        The orientation is portrait or portraitUpDown
    */
    public var isPortrait : Bool{
        return self.contains(.portrait) || self.contains(.portraitUpsideDown);
    }
    
    /**
        The orientation is landscapeLeft or landsacpeRight
    */
    public var isLandscape : Bool{
        return self.contains(.landscapeRight) || self.contains(.landscapeRight) || self.contains(.landscape);
    }
    
    /**
        Orientations contained in this mask
    */
    public var orientations : [UIInterfaceOrientation]{
        var values : [UIInterfaceOrientation] = [];
        
        if self.contains(.portrait){
            values.append(.portrait);
        }
        
        if self.contains(.portraitUpsideDown){
            values.append(.portraitUpsideDown);
        }
        
        if self.contains(.landscapeRight){
            values.append(.landscapeRight);
        }
        
        if self.contains(.landscapeLeft){
            values.append(.landscapeLeft);
        }
        
        return values;
    }
}
