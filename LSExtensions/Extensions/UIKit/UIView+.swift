//
//  UIView+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2017. 6. 29..
//  Copyright © 2017년 leesam. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    /// Whether to be changed when the device is on dark mode or color inversed
    @IBInspectable public var ignoresDarkMode: Bool {
        get {
            if #available(iOS 11.0, *) {
                return self.accessibilityIgnoresInvertColors
            }
            return false
        }
        set(value) {
            if #available(iOS 11.0, *) {
                self.accessibilityIgnoresInvertColors = value;
            }
        }
    }
    
    /// Accesor for identifier to use at UITest?
    @IBInspectable public var uiTestIdentifier: String? {
        get {
            return self.accessibilityIdentifier;
        }
        set(value) {
            self.accessibilityIdentifier = value;
        }
    }
    
    /// Get layout constraints for width of this(FirstAnchor is this and FirstAttribute is width)
    open var widthConstraints : [NSLayoutConstraint]{
        return self.constraints.filter { (constraint) -> Bool in
            var value = false;
            if #available(iOS 10.0, *) {
                value = self.isEqual(constraint.firstItem)
                    && constraint.firstAnchor == self.widthAnchor
                    && constraint.firstAttribute == .width
            } else {
                value = self.isEqual(constraint.firstItem)
                    && constraint.firstAttribute == .width
            };

            return value;
        };
    }
    
    /// get layout constraints for height
    open var heightConstraints : [NSLayoutConstraint]{
        return self.constraints.filter { (constraint) -> Bool in
            var value = false;
            if #available(iOS 10.0, *) {
                value = self.isEqual(constraint.firstItem)
                    && constraint.firstAnchor == self.heightAnchor
                    && constraint.firstAttribute == .height
            } else {
                value = self.isEqual(constraint.firstItem)
                    && constraint.firstAttribute == .height
            };

            return value;
        };
    }
    
    /**
        Capture screenshot of this view with given scale
     - parameter scale: scale for screenshot
    */
    public func renderImage(_ scale : CGFloat = 1.0) -> UIImage?{
        var value : UIImage?;
        
        autoreleasepool { () -> () in
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 2.0);
            
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true);
            
            value = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
        }
        
        return value;
    }
    
    /**
     Remove all sub views from this
     */
    public func clearSubViews(){
        let views = self.subviews;
        for v in views{
            v.removeFromSuperview();
        }
    }
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    /**
     Sets the color rule of this, when this is appeared as Popover
     */
    @IBInspectable
    public var tintGrayPopover : Bool{
        get{
            return self.tintAdjustmentMode == .automatic;
        }
        
        set(value){
            self.tintAdjustmentMode = value ? .dimmed : .normal;
        }
    }
    
    /**
     Gets UIViewController contains this
     */
    public var viewController : UIViewController?{
        get{
            var value : UIViewController?;
            
            //go to next view
            guard let next = self.next else{
                return value;
            }
            
            //If next responder is not UIViewController
            if next is UIViewController{
                value = next as? UIViewController;
            } else{
                //Gets viewController of next(parent) UIView
                value = (next as? UIView)?.viewController;
            }
            
            return value;
        }
    }
    
    /**
     Gets Layout Constraint with given identifier
     - parameter identifier:
     */
    public func getConstraint(_ identifier: String) -> NSLayoutConstraint?{
        return self.constraints.first{ $0.identifier == identifier }
    }
    
    public func hasView<T : UIView>(type: T.Type) -> Bool{
        return !self.subviews.filter({ (view) -> Bool in
            return view is T || view.hasView(type: type);
        }).isEmpty;
    }
    
    /*func getView<T : UIView>(type: T.Type) -> T?{
     var value = self.subviews.filter({ (view) -> Bool in
     LS.debug("check subview \(LS.getClassName(view.classForCoder)) == \(LS.getClassName(T.self)) in \(LSUIUtil.getClassName(self.classForCoder))");
     //            print("check subview %@ == %@ in %@", LSUIUtil.getClassName(view.classForCoder), LSUIUtil.getClassName(self.classForCoder));
     return view is T;
     }).first as? T;
     
     guard value == nil else {
     return value;
     }
     
     for view in self.subviews{
     value = view.getView(T);
     guard value == nil else {
     break;
     }
     }
     
     return value;
     }*/
    
    /*func printViewTree() -> Void{
     for view in self.subviews{
     print("print subview %@ in %@", LSUIUtil.getClassName(view.classForCoder), LSUIUtil.getClassName(self.classForCoder));
     view._printViewTree();
     }
     }*/
    
    /*private func _printViewTree(depth : Int = 0) -> Void{
     for view in self.subviews{
     //"".stringByPaddingToLength(depth, withString: " ", startingAtIndex: 0)
     print("print subview[%d] view[%@] super[%@]", depth, LSUIUtil.getClassName(view.classForCoder), LSUIUtil.getClassName(self.classForCoder));
     view._printViewTree(depth + 1);
     }
     }*/
    
    /*public func printSuperTree() -> Void{
     var currClass : AnyClass? = self.classForCoder;
     
     
     while currClass != nil {
     var superName = "";
     if currClass?.superclass() != nil{
     superName = LSUIUtil.getClassName(currClass!.superclass()!);
     }
     
     print("%@ - super[%@]", LSUIUtil.getClassName(currClass!), superName);
     currClass = currClass?.superclass();
     }
     }*/
    
    class LSGradientBackgroundLayer : CAGradientLayer{
        
    }
    
    @IBInspectable
    public var GradientBackgroundStartColor : UIColor{
        get{
            let color_obj = self.GradientBackgroundLayer?.colors?.first;
            var color = UIColor.clear.cgColor;
            if color_obj != nil{
                color = color_obj as! CGColor;
            }
            
            return UIColor(cgColor: color);
        }
        
        set(value){
            let layer = self.GradientBackgroundLayer;
            guard layer != nil else{
                return;
            }
            
            layer?.colors = [value.cgColor, self.GradientBackgroundEndColor.cgColor];
            
            //            layer?.removeFromSuperlayer();
            //            self.layer.insertSublayer(layer!, atIndex: 0);
        }
    }
    
    @IBInspectable
    public var GradientBackgroundEndColor : UIColor{
        get{
            let color_obj = self.GradientBackgroundLayer?.colors?.last;
            var color = UIColor.clear.cgColor;
            if color_obj != nil{
                color = color_obj as! CGColor;
            }
            
            return UIColor(cgColor: color);
        }
        
        set(value){
            let layer = self.GradientBackgroundLayer;
            
            guard layer != nil else{
                return;
            }
            
            layer?.colors = [self.GradientBackgroundStartColor.cgColor, value.cgColor];
            
            //            layer?.removeFromSuperlayer();
            //            self.layer.insertSublayer(layer!, atIndex: 0);
        }
    }
    
    private var GradientBackgroundLayer : LSGradientBackgroundLayer?{
        get{
            var layer = self.layer.sublayers?.filter({ (layer) -> Bool in
                return layer is LSGradientBackgroundLayer;
            }).first as? LSGradientBackgroundLayer;
            
            guard layer == nil else{
                return layer;
            }
            
            let gd_layer = LSGradientBackgroundLayer();
            gd_layer.frame = self.bounds;
            
            //            gd_layer.colors = [self.GradientBackgroundStartColor.CGColor, self.GradientBackgroundEndColor.CGColor];
            gd_layer.colors = [UIColor.black.cgColor, UIColor.white.cgColor];
            gd_layer.startPoint = CGPoint(x: 0, y: 0.5);
            gd_layer.endPoint = CGPoint(x: 1, y: 0.5);
            
            self.layer.insertSublayer(gd_layer, at: 0);
            layer = gd_layer;
            
            return layer;
        }
    }
    
    public func fitGradientBackground(){
        let layer = self.layer.sublayers?.filter({ (layer) -> Bool in
            return layer is LSGradientBackgroundLayer;
        }).first as? LSGradientBackgroundLayer;
        
        guard layer != nil else{
            return;
        }
        
        layer?.frame = self.bounds;
    }
    
    /**
         Rotates this by given angle and given anchor
         - parameter angle: Degree to rotate this view
         - parameter anchor: The anchor for rotation
     */
    public func rotate(_ angle: CGFloat, anchor: CGPoint = CGPoint.init(x: 0.5, y: 0.5)){
        let radian = angle / 180.0 * CGFloat(Double.pi);
        let anchorOffset = CGPoint.init(x: anchor.x - self.layer.anchorPoint.x, y: anchor.y - self.layer.anchorPoint.y);
        self.layer.anchorPoint = anchor;
            //CGPoint(x: anchor.x * self.frame.width, y: anchor.y * self.frame.height);
        self.transform = self.transform.rotated(by: radian);
        self.transform = self.transform.translatedBy(x: anchorOffset.x * self.frame.width, y: anchorOffset.y * self.frame.height);
    }
    
    /**
        Get current first responder from this view
    */
    public var currentFirstResponder : UIView? {
        if self.isFirstResponder {
            return self
        }
        
        for view in self.subviews {
            if let responder = view.currentFirstResponder {
                return responder
            }
        }
        
        return nil
    }
    
    /**
     Wrapper of layer.borderColor for inspector in storyboard or xib
     */
    @IBInspectable
    public var borderUIColor : UIColor?{
        get{
            return UIColor.init(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor);
        }
        
        set(value){
            self.layer.borderColor = value?.cgColor;
        }
    }
    
    /**
     Wrapper of layer.borderWidth for inspector in storyboard or xib
     */
    @IBInspectable
    public var borderWidth : CGFloat{
        get{
            return self.layer.borderWidth;
        }
        set(value){
            self.layer.borderWidth = value;
        }
    }
    
    /**
     Wrapper of layer.cornerRadius for inspector in storyboard or xib
     */
    @IBInspectable
    public var cornerRadius : CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set(value){
            self.layer.cornerRadius = value;
        }
    }
    
    /**
        Find and returns parent view which type is same as given type
        - parameter type : parent view type to find
        - returns : parent view found by given type
    */
    public func parent<T : UIView>(type: T.Type) -> T?{
        let parent = self.superview;
        
        return parent is T ? parent as? T : parent?.parent(type: T.self);
    }
    
    /**
         returns first subview matched gived type
         - parameter type: type of subviews to find
     */
    public func first<T : UIView>(type: T.Type) -> T?{
        var value : T? = self.subviews.compactMap{ $0 as? T }.first;
        guard value == nil else{
            return value;
        }
        
        value = self.subviews.compactMap{ $0.first(type: type) }.first;
        return value;
    }
    
    /**
         returns subviews matched given type
         - parameter type: type of subview to find
     */
    public func children<T : UIView>(type: T.Type) -> [T]{
        
        return self.subviews.flatMap({ (view) -> [T] in
            var values : [T] = [];
            if let value = view as? T{
                values.append(value);
            }else{
                values.append(contentsOf: view.children(type: type));
            }
            
            return values;
        })
    }
}

// MARK: Borders
extension UIView{
    private struct BorderPropertyKeys{
        static var left = "uiview.border.left";
        static var right = "uiview.border.right";
        static var top = "uiview.border.top";
        static var bottom = "uiview.border.bottom";
    }

    private func _createNewBorderLineView() -> UIView{
        let value = UIView();
        value.translatesAutoresizingMaskIntoConstraints = false;
        
        self.addSubview(value);
        return value;
    }
    
    /**
        Property to get/set width of left border
        use color - borderColor : layer.borderColor;
    */

    @IBInspectable
    public var borderLeftWidth : CGFloat{
        get{
            let borderLineView = self.objcProperty(&UIView.BorderPropertyKeys.left) as? UIView;
            return borderLineView?.frame.width ?? 0.0;
        }

        set(value){
            var borderLineView : UIView! = self.objcProperty(&UIView.BorderPropertyKeys.left) as? UIView;

            if borderLineView == nil{
                borderLineView = self._createNewBorderLineView();
                
                borderLineView?.widthAnchor.constraint(equalToConstant: value).isActive = true;
                borderLineView?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                borderLineView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                borderLineView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                
                self.setObjcProperty(&UIView.BorderPropertyKeys.left, value: borderLineView, policy: .OBJC_ASSOCIATION_RETAIN);
                borderLineView = self.objcProperty(&UIView.BorderPropertyKeys.left) as? UIView;
                //print("create new left border. line[\(borderLineView)]");
            }

            borderLineView.backgroundColor = self.borderUIColor;
            borderLineView.widthConstraints.first?.constant = value;
            self.bringSubviewToFront(borderLineView);
            //borderLayer?.frame = CGRect.init(x: 0, y: 0, width: value, height: self.frame.height);
        }
    }
    
    
    /**
        Property to get/set width of right border
        use color - borderColor : layer.borderColor;
    */

    @IBInspectable
    public var borderRightWidth : CGFloat{
        get{
            let borderLineView = self.objcProperty(&UIView.BorderPropertyKeys.right) as? UIView;
            return borderLineView?.frame.width ?? 0.0;
        }

        set(value){
            var borderLineView : UIView! = self.objcProperty(&UIView.BorderPropertyKeys.right) as? UIView;

            if borderLineView == nil{
                borderLineView = self._createNewBorderLineView();
                
                borderLineView?.widthAnchor.constraint(equalToConstant: value).isActive = true;
                borderLineView?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                borderLineView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                borderLineView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                
                self.setObjcProperty(&UIView.BorderPropertyKeys.right, value: borderLineView, policy: .OBJC_ASSOCIATION_RETAIN);
                borderLineView = self.objcProperty(&UIView.BorderPropertyKeys.right) as? UIView;
                //print("create new left border. line[\(borderLineView)]");
            }

            borderLineView.backgroundColor = self.borderUIColor
            borderLineView.widthConstraints.first?.constant = value;
            self.bringSubviewToFront(borderLineView);
            //borderLayer?.frame = CGRect.init(x: 0, y: 0, width: value, height: self.frame.height);
        }
    }
    
    /**
        Property to get/set width of bottom border
        use color - borderColor : layer.borderColor;
    */

    @IBInspectable
    public var borderBottomWidth : CGFloat{
        get{
            let borderLineView = self.objcProperty(&UIView.BorderPropertyKeys.bottom) as? UIView;
            return borderLineView?.frame.width ?? 0.0;
        }

        set(value){
            var borderLineView : UIView! = self.objcProperty(&UIView.BorderPropertyKeys.bottom) as? UIView;

            if borderLineView == nil{
                borderLineView = self._createNewBorderLineView();
                
                borderLineView?.heightAnchor.constraint(equalToConstant: value).isActive = true;
                borderLineView?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                borderLineView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                borderLineView?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                
                self.setObjcProperty(&UIView.BorderPropertyKeys.bottom, value: borderLineView, policy: .OBJC_ASSOCIATION_RETAIN);
                borderLineView = self.objcProperty(&UIView.BorderPropertyKeys.bottom) as? UIView;
                //print("create new left border. line[\(borderLineView)]");
            }

            borderLineView.backgroundColor = self.borderUIColor
            borderLineView.widthConstraints.first?.constant = value;
            self.bringSubviewToFront(borderLineView);
            //borderLayer?.frame = CGRect.init(x: 0, y: 0, width: value, height: self.frame.height);
        }
    }
    
    /**
        Property to get/set width of top border
        use color - borderColor : layer.borderColor;
    */

   @IBInspectable
   public var borderTopWidth : CGFloat{
        get{
            let borderLineView = self.objcProperty(&UIView.BorderPropertyKeys.top) as? UIView;
            return borderLineView?.frame.width ?? 0.0;
        }

        set(value){
            var borderLineView : UIView! = self.objcProperty(&UIView.BorderPropertyKeys.top) as? UIView;

            if borderLineView == nil{
                borderLineView = self._createNewBorderLineView();
                
                borderLineView?.heightAnchor.constraint(equalToConstant: value).isActive = true;
                borderLineView?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                borderLineView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                borderLineView?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                
                self.setObjcProperty(&UIView.BorderPropertyKeys.top, value: borderLineView, policy: .OBJC_ASSOCIATION_RETAIN);
                borderLineView = self.objcProperty(&UIView.BorderPropertyKeys.top) as? UIView;
                //print("create new left border. line[\(borderLineView)]");
            }

             borderLineView.backgroundColor = self.borderUIColor
            borderLineView.widthConstraints.first?.constant = value;
            self.bringSubviewToFront(borderLineView);
            //borderLayer?.frame = CGRect.init(x: 0, y: 0, width: value, height: self.frame.height);
        }
   }
    
    /**
        bring all borders to front of this view
     */
    func bringBordersToFront(){
        let borders : [UIView] = [self.objcProperty(&UIView.BorderPropertyKeys.left) as? UIView,
                                  self.objcProperty(&UIView.BorderPropertyKeys.right) as? UIView,
                                  self.objcProperty(&UIView.BorderPropertyKeys.top) as? UIView,
                                self.objcProperty(&UIView.BorderPropertyKeys.bottom) as? UIView].compactMap{ $0 }
        
        borders.forEach{ self.bringSubviewToFront($0) }
    }
}

// MARK: Shadow
extension UIView{
    @IBInspectable
    open var shadowRadius : CGFloat{
        get{
            return self.layer.shadowRadius;
        }
        
        set{
            self.layer.shadowRadius = newValue;
        }
    }
    
    @IBInspectable
    open var shadowOpacity : Float{
        get{
            return self.layer.shadowOpacity;
        }
        
        set{
            self.layer.shadowOpacity = newValue;
        }
    }
    
    @IBInspectable
    open var shadowUIColor : UIColor!{
        get{
            guard let color = self.layer.shadowColor else{
                return nil;
            }
            
            return UIColor.init(cgColor: color);
        }
        
        set{
            self.layer.shadowColor = newValue?.cgColor;
        }
    }
    
    @IBInspectable
    open var shadowOffset : CGSize{
        get{
            return self.layer.shadowOffset;
        }
        
        set{
            self.layer.shadowOffset = newValue;
        }
    }
    
    open var isVisible : Bool{
        get{
            return !self.isHidden;
        }
        
        set{
            self.isHidden = !newValue;
        }
    }
}
