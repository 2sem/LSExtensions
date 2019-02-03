//
//  UIButton.swift
//  WhoCallMe
//
//  Created by 영준 이 on 2016. 4. 14..
//  Copyright © 2016년 leesam. All rights reserved.
//

import UIKit

extension UIButton{
    /**
     property to control templated image for the selected status of this button
     */
    @IBInspectable
    open var templatedSelectedImage : UIImage?{
        get{
            return self.image(for: .selected);
        }
        
        set(value){
            let image = value?.withRenderingMode(.alwaysTemplate);
            self.setImage(image, for: .selected);
        }
    }
    
    /**
     property to control templated image for the normal status of this button
     */
    @IBInspectable
    open var templatedImage : UIImage?{
        get{
            return self.image(for: .normal);
        }
        
        set(value){
            let image = value?.withRenderingMode(.alwaysTemplate);
            self.setImage(image, for: .normal);
        }
    }
    
    /**
        Fit image of this button as aspec scale
    */
    public var imageAspectFit : Bool{
        get{
            var value = false;
            guard self.imageView != nil else{
                return value;
            }
            
            value = self.imageView?.contentMode == .scaleAspectFit;
            return value;
        }
        set(value){
            if value{
                self.imageView?.contentMode = .scaleAspectFit;
            }
        }
    }
    
    /**
        Align title to center
    */
    public var titleCenter : Bool{
        get{
            return true;
        }
        
        set(value){
            if value{
                self.imageView?.isHidden = false;
                self.titleLabel?.isHidden = false;
                
                self.layoutIfNeeded();
            }
        }
    }
    
    /**
         Indication whether content of this button is overflowed and truncated
     */
    public var isOverFlowed : Bool{
        guard let label = self.titleLabel else{
            return false;
        }
        
        guard label.numberOfLines != 0 else{
            return false;
        }
        
        //label.bounds
        return !self.contentSize.contains(label.rectForText);
    }
    
    /**
         Size of the content in this button
     */
    public var contentSize : CGRect{
        return CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: self.frame.width - contentEdgeInsets.left - contentEdgeInsets.right, height: self.frame.height - contentEdgeInsets.top - contentEdgeInsets.bottom));
    }
    
    /**
         set attributed title with the plain title of this
         - parameter for: button state to set attibuted title
     */
    open func makeTitleAttributed(for state: UIControlState = .normal){
        guard let normalText = self.title(for: state) else{
            return;
        }
        
        guard let font = self.titleLabel?.font else{
            return;
        }
        
        self.setAttributedTitle(normalText.attributed(font: font), for: state);
    }
    
    /**
        Returns new button created with the properties of this
    */
    public func clone() -> UIButton{
        let value : UIButton = UIButton.init();
        value.setTitle(self.title(for: .normal), for: .normal);
        value.setTitle(self.title(for: .selected), for: .selected);
        value.setTitle(self.title(for: .highlighted), for: .highlighted);
        value.setTitle(self.title(for: .disabled), for: .disabled);
        
        value.setImage(self.image(for: .normal), for: .normal);
        value.setImage(self.image(for: .selected), for: .selected);
        value.setImage(self.image(for: .highlighted), for: .highlighted);
        value.setImage(self.image(for: .disabled), for: .disabled);
        
        value.setTitleColor(self.titleColor(for: .normal), for: .normal);
        value.setTitleColor(self.titleColor(for: .selected), for: .selected);
        value.setTitleColor(self.titleColor(for: .highlighted), for: .highlighted);
        value.setTitleColor(self.titleColor(for: .disabled), for: .disabled);
        
        value.setBackgroundImage(self.backgroundImage(for: .normal), for: .normal);
        value.setBackgroundImage(self.backgroundImage(for: .selected), for: .selected);
        value.setBackgroundImage(self.backgroundImage(for: .highlighted), for: .highlighted);
        value.setBackgroundImage(self.backgroundImage(for: .disabled), for: .disabled);
        
        value.setTitleShadowColor(self.titleShadowColor(for: .normal), for: .normal);
        value.setTitleShadowColor(self.titleShadowColor(for: .selected), for: .selected);
        value.setTitleShadowColor(self.titleShadowColor(for: .highlighted), for: .highlighted);
        value.setTitleShadowColor(self.titleShadowColor(for: .disabled), for: .disabled);
        
        value.tintColor = self.tintColor;
        value.backgroundColor = self.backgroundColor;
        value.contentEdgeInsets = self.contentEdgeInsets;
        value.imageEdgeInsets = self.imageEdgeInsets;
        value.titleEdgeInsets = self.titleEdgeInsets;
        
        value.layer.borderColor = self.layer.borderColor;
        value.layer.borderWidth = self.layer.borderWidth;
        value.layer.cornerRadius = self.layer.cornerRadius;
        
        return value;
    }
}
