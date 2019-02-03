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
        guard let index = views.index(of: viewController) else{
            return;
        }
        views.remove(at: index);
        self.setViewControllers(views, animated: animated);
    }
}
