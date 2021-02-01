//
//  UINavigationController+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2019. 2. 3..
//  Copyright © 2019년 leesam. All rights reserved.
//

import UIKit

extension UINavigationController{
    /**
     pop viewcontoller from this navigation
     */
    open func pop(viewController: UIViewController, animated: Bool = false){
        var views = self.viewControllers;
        guard let index = views.firstIndex(of: viewController) else{
            return;
        }
        views.remove(at: index);
        self.setViewControllers(views, animated: animated);
    }
    
    /**
         Prevent to push  self duplicated to navigation controller
         - Parameters:
             - viewController: View controller to push to navigation controller
             - animated: Whether to animate pushing
     */
    open func safePushViewController(_ viewController: UIViewController, animated: Bool){
        guard viewController !== self else{
            return;
        }

        guard !self.viewControllers.contains(viewController) else{
            return;
        }

        self.pushViewController(viewController, animated: animated);
    }
}
