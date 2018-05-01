//
//  UIViewController+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2017. 4. 23..
//  Copyright © 2017년 leesam. All rights reserved.
//

import Foundation

import UIKit
import CoreLocation

extension UIViewController {
    /**
     Window presenting this
    */
    public var window : UIWindow?{
        get{
            return UIApplication.shared.windows.first{ $0 === self.rootViewController }
        }
    }
    
    /**
     Root UIViewController presenting this
    */
    public var rootViewController: UIViewController?{
        guard let parent = self.parent else{
            return self;
        }
        
        return parent;
    }
    
    /**
     Top UIViewController of this if this is container view controller
         - requires: this should be UINavigationContoller/UITabBarController/UIAlertController
    */
    public var mostTopViewController : UIViewController?{
        get{
            var value : UIViewController?;
            if let nav = self as? UINavigationController{
                value = nav.visibleViewController;
            }else if let tab = self as? UITabBarController{
                value = tab.selectedViewController;
            }else if value?.presentedViewController != nil{
                if value?.presentedViewController is UIAlertController{
                    //ignore UIAlertController, so it consider as end view controller
                }else{
                    value = value?.presentedViewController;
                }
            }
            
            let top = value?.mostTopViewController;
            return top != nil ? top : value;
        }
    }
    
    /**
        Presents Alert Controller generated with given information and returns it
         - parameter title: title of UIAlertController to present
         - parameter msg: message of UIAlertController to present
         - parameter style: style of UIAlertController to present
         - parameter sourceView: source view for popover
         - parameter sourceRect: source rect for popover
         - parameter popoverDelegate: delegate for popover
         - parameter completion: block to be called when presenting UIAlertController has been completed
         - note: UIAlertController will be presented as popover if given style is ActionSheet and this app is launched on iPad
         - returns: Alert Controller generated with given information and returns it
    */
    @discardableResult
    public func showAlert(title: String, msg: String, actions : [UIAlertAction], style: UIAlertControllerStyle, sourceView: UIView? = nil, sourceRect: CGRect? = nil, popoverDelegate: UIPopoverPresentationControllerDelegate? = nil, completion: (() -> Void)? = nil) -> UIAlertController{
        let alert = UIAlertController(title: title, message: msg, preferredStyle: style);
        for act in actions{
            alert.addAction(act);
        };
        
        //UIAlertController is presented as popover if the style of it is ActionSheet and this app is launched on iPad
        if style == .actionSheet && alert.modalPresentationStyle == .popover{
            alert.popoverPresentationController?.sourceView = sourceView;
            if sourceRect != nil{
                alert.popoverPresentationController?.sourceRect = sourceRect!;
            }
            
            alert.popoverPresentationController?.delegate = popoverDelegate;
            //UIModalPresentationPopover
            //sourceView and sourceRect or a barButtonItem
        }
        
        self.present(alert, animated: false, completion: completion);
        return alert;
    }
    
    /**
        Presens UIAlertController containing UIActivityIndicatorView to indicate progressing
         - parameter title: title of UIAlertController
         - parameter msg: message of UIAlertController
         - parameter completion: block to be called after presenting UIAlertController has been completed
         - returns: UIAlertController containing UIActivityIndicatorView to indicate progressing
    */
    public func showIndicator(title: String?, msg: String = "\n\n\n", completion: (() -> Void)? = nil) -> UIAlertController{
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert);
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge);
        indicator.center = CGPoint(x: 130, y: 65);
        indicator.color = UIColor.black;
        indicator.startAnimating();
        
        alert.view.addSubview(indicator);
        self.present(alert, animated: true, completion: completion);
        
        return alert;
    }
    
    /**
        Presens UIAlertController containing Security TextField to input the Password
         - parameter title: title of UIAlertController
         - parameter msg: message of UIAlertController
         - parameter completion: block to be called after presenting UIAlertController has been completed
         - parameter OK: Button title to do something with the Password
         - parameter validationHandler: Handler to validate password
             - parameter password: Password input on UIAlertController
         - parameter completion: block to be called when presenting UIAlertController has been completed
         - note:
                Default validation button name is "OK"
                you can localize title of the cancel button "Cancel"
         - returns: UIAlertController containing UITextField to get password
    */
    @discardableResult
    public func showPasscode(title: String?, msg: String, buttonTitle: String? = "OK", validationHandler: ((_ password: String) -> Bool)? = nil, completion: (() -> Void)? = nil) -> UIAlertController{
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert);
        
        alert.addTextField { (txt) -> Void in
            txt.placeholder = "Input password";
            txt.isSecureTextEntry = true;
        };
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: { (act) -> Void in
        }));
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (act) -> Void in
            let txt = alert.textFields?.first;
            
            guard txt?.text != nil else{
                return;
            }
            
            //if validation has been failed
            if validationHandler?(txt!.text!) == false {
                self.showPasscode(title: title, msg: msg, buttonTitle: buttonTitle, validationHandler: validationHandler, completion: completion);
            }
        }));
        
        self.present(alert, animated: true, completion: completion);
        
        return alert;
    }
    
    /**
     Presents given UIViewController as Popover on this
     - parameter inView: UIViewController to present as Popover
     - parameter buttonToShow: UIBarButtonItem which is the begin of arrow for Popover
     - parameter permittedArrowDirections: Direction of Arrow for Popover
     - parameter animated: Indication whether present popover with the animation
     - parameter color: Background Color of Popover
     - returns: UIPopoverPresentationController for new Popover on this
    */
    public func popOverFromButton(inView: UIViewController, buttonToShow: UIBarButtonItem, permittedArrowDirections : UIPopoverArrowDirection, animated : Bool=true, color: UIColor? = nil) -> UIPopoverPresentationController?{
        self.modalPresentationStyle = .popover;
        let pop = self.popoverPresentationController;
        
        if inView.presentedViewController === self {
            return inView.presentedViewController?.popoverPresentationController;
        }
        else if inView.presentedViewController != nil {
            inView.presentedViewController?.dismiss(animated: false, completion: nil);
        }
        pop?.permittedArrowDirections = .any;
        pop?.barButtonItem = buttonToShow;
        pop?.permittedArrowDirections = permittedArrowDirections;
        pop?.backgroundColor = color;
        if inView is UIPopoverPresentationControllerDelegate{
            pop?.delegate = inView as? UIPopoverPresentationControllerDelegate;
        }
        print("pop delegate[\(pop!.delegate?.description ?? "")]");
        
        inView.present(self, animated: animated, completion: nil);
        
        return pop;
    }
    
    /**
     Presents given UIViewController as Popover on this
     - parameter inView: UIViewController to present as Popover
     - parameter popOverDelegate: delegate for Popover
     - parameter viewToShow: UIView to use as the begin of arrow instead UIBarButtonItem
     - parameter rectToShow: Area to use as the begin of arrow instead UIBarButtonItem
     - parameter permittedArrowDirections: Direction of Arrow for Popover
     - parameter animated: Indication whether present popover with the animation
     - parameter color: Background Color of Popover
     - parameter completion: block to be called when presenting this has been completed
     - returns: UIPopoverPresentationController for new Popover on this
     */
    public func popOver(inView: UIViewController, popOverDelegate delegate: UIPopoverPresentationControllerDelegate? = nil, viewToShow view: UIView, rectToShow rect: CGRect, permittedArrowDirections : UIPopoverArrowDirection, animated : Bool, color: UIColor? = nil, completion: (() -> Void)? = nil) -> UIPopoverPresentationController?{
        var pop = self.popoverPresentationController;
        self.modalPresentationStyle = .popover;
        
        pop = self.popoverPresentationController;
        
        if inView.presentedViewController === self {
            return inView.presentedViewController?.popoverPresentationController;
        }
        else if inView.presentedViewController != nil {
            inView.presentedViewController?.dismiss(animated: false, completion: nil);
        }
        
        pop?.permittedArrowDirections = permittedArrowDirections;
        pop?.sourceView = view;
        pop?.sourceRect = rect;
        pop?.backgroundColor = color;
        
        if delegate != nil{
            pop?.delegate = delegate;
        }
        
        if inView is UIPopoverPresentationControllerDelegate{
            pop?.delegate = inView as? UIPopoverPresentationControllerDelegate;
        }
        print("pop delegate[\(pop!.delegate?.description ?? "")]");
        
        inView.present(self, animated: true, completion: completion);
        
        return pop;
    }
    
    /**
     Indication whether this is presented as Popover
    */
    public var isPopover : Bool{
        get{
            var value = self.popoverPresentationController != nil;
            
            guard !value else{
                return value;
            }
            
            value = self.parent?.isPopover ?? false;
            //            value = self.presentingViewController?.isPopover ?? false;
            
            return value;
        }
    }
    
    /**
     Returns child UIViewController is given Type
     - parameter type: UIViewController's type to get
     - returns: child UIViewController found out in this by given Type
    */
    public func childViewController<T : UIViewController>(type: T.Type) -> T?{
        return self.childViewControllers.filter({ (view) -> Bool in
            return view.isKind(of: type);
        }).first as? T;
    }
    
    public func backupProperty<P>(value: inout P, getter: (UIViewController) -> P){
        value = getter(self);
    }
    
    public func restoreProperty<P>(value: inout P, setter: (UIViewController, P) -> Void){
        setter(self, value);
    }
    
    public func backupNavigationBarHidden( hidden : inout Bool){
        hidden = (self.navigationController?.isNavigationBarHidden ?? false);
    }
    
    public func restoreNavigationBarHidden( hidden: inout Bool){
        self.navigationController?.isNavigationBarHidden = hidden;
    }
    
    public func backupNavigationBarTranslucent( translucent : inout Bool){
        translucent = (self.navigationController?.navigationBar.isTranslucent ?? false);
    }
    
    public func restoreNavigationBarTranslucent( translucent: inout Bool){
        self.navigationController?.navigationBar.isTranslucent = translucent;
    }
    
    public func backupTabBarTranslucent( translucent : inout Bool){
        translucent = (self.tabBarController?.tabBar.isTranslucent ?? false);
    }
    
    public func restoreTabBarTranslucent( translucent: inout Bool){
        self.tabBarController?.tabBar.isTranslucent = translucent;
    }
    
    /**
     Presents UIAlertController to notify you need to change the setting for this app to do something and provide button to open Settings App.
     - parameter title: title of UIAlertController to present
     - parameter msg: message of UIAlertController to present
     - parameter style: style of UIAlertController to present
     - parameter titleForOK: title of "OK" button
     - parameter titleForSettings: title of "Settings" button
    */
    public func openSettingsOrCancel(title: String = "Something is disabled", msg: String = "Please enable to do something", style: UIAlertControllerStyle = .alert, titleForOK: String = "OK", titleForSettings: String = "Settings"){
        let acts = [UIAlertAction(title: titleForSettings, style: .default, handler: { (act) in
            UIApplication.shared.openSettings();
        }), UIAlertAction(title: titleForOK, style: .default, handler: nil)];
        self.showAlert(title: title, msg: msg, actions: acts, style: style);
    }
    
    /**
     Presents UIAlertController to notify you need to cellular data or Wi-Fi to do something.
     - parameter title: title of UIViewController
     - parameter okHandler: Handler for OK Button
     - parameter cancelHandler: Handler for Cancel Button
    */
    public func showCellularAlert(title: String, okHandler : ((UIAlertAction) -> Void)? = nil, cancelHandler : ((UIAlertAction) -> Void)? = nil){
        self.showAlert(title: title, msg: "Turn on cellular data or use Wi-Fi to access data".localized(), actions: [UIAlertAction(title: "Cancel".localized(), style: .default, handler: cancelHandler), UIAlertAction(title: "OK".localized(), style: .default, handler: okHandler)], style: .alert);
    }
    
    /**
     Presents UIActivityViewController to share given item to another app
     - parameter activityItems: items to share to another app
     - parameter applicationActivities: app filter to shared
     - parameter completion: block to be called when presenting share activity has been completed
    */
    public func share(_ activityItems: [Any], applicationActivities: [UIActivity]? = nil, excludedActivities: [UIActivityType] = [], completion: (() -> Void)? = nil){
        let controller = UIActivityViewController.init(activityItems: activityItems, applicationActivities: applicationActivities);
        controller.popoverPresentationController?.sourceView = self.view;
        controller.excludedActivityTypes = excludedActivities;
        //        controller.excludedActivityTypes = [.mail, .message, .postToFacebook, .postToTwitter];
        self.present(controller, animated: true, completion: completion);
    }
}

