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
        self.layer.anchorPoint = CGPoint(x: anchor.x / self.frame.width, y: anchor.y / self.frame.height);
        self.transform = self.transform.translatedBy(x: -anchor.x, y: 0);
        self.transform = self.transform.rotated(by: radian);
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
        var parent = self.superview;
        
        return parent is T ? parent as? T : parent?.parent(type: T.self);
    }
}
