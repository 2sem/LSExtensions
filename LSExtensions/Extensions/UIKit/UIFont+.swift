//
//  UIFont+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2021/01/31.
//  Copyright © 2021 leesam. All rights reserved.
//

import UIKit

extension UIFont{
    /**
        Returns brother font for this font with given font style
    */
    public func withSymbolic(traits : UIFontDescriptor.SymbolicTraits) -> UIFont?{
        guard let newFontDesc = self.fontDescriptor.withSymbolicTraits(traits) else{
            return nil;
        }
        
        return UIFont.init(descriptor: newFontDesc, size: self.pointSize);
    }
}

