//
//  UIPopoverPresentationController+.swift
//  pallyconswiftdemo
//
//  Created by 영준 이 on 2018. 6. 23..
//  Copyright © 2018년 leesam. All rights reserved.
//

import UIKit

extension UIPopoverPresentationController{
    /**
        Copy properties of this to destination to be presented same as current popover
         - parameter destination: Destination to copy properties of this.
    */
    public func copy(to destination: UIPopoverPresentationController){
        destination.sourceView = self.sourceView;
        destination.sourceRect = self.sourceRect;
        
        destination.barButtonItem = self.barButtonItem;
        destination.backgroundColor = self.backgroundColor;
        destination.canOverlapSourceViewRect = self.canOverlapSourceViewRect;
        
        destination.delegate = self.delegate;
    }
}
