//
//  UIPopoverPresentationControllerDelegate+.swift
//  siwonlectureroom
//
//  Created by 이영준 on 2018. 7. 19..
//  Copyright © 2018년 siwonschool. All rights reserved.
//

import UIKit

extension UIPopoverPresentationControllerDelegate{
    public static var `default` : UIPopoverPresentationControllerDelegate { return _UIPopoverPresentationControllerDefaultDelegate.default }
}

class _UIPopoverPresentationControllerDefaultDelegate : NSObject, UIPopoverPresentationControllerDelegate{
    public static let `default` = _UIPopoverPresentationControllerDefaultDelegate();
    
    /**
         You can not present popover properly on Landspace unless use this
     */
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none;
    }
    
    /**
         You can not present popover properly on Landspace unless use this
     */
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none;
    }
    
}
