//
//  NSAttributedString+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2019. 2. 2..
//  Copyright © 2019년 leesam. All rights reserved.
//

import UIKit

extension NSAttributedString{
    /**
        returns new attributed string with given parameters
        - parameter string: the string to create attributed string with
        - parameter font: the text font to create attributed string with
        - parameter font: the text color to create attributed string with
        - parameter font: the attributes to create attributed string with
    */
    public convenience init(_ string: String, font: UIFont!, foreground: UIColor? = nil, attributes: [NSAttributedString.Key : Any] = [:]){
        var attributes = attributes;
        if let font = font{
            attributes[.font] = font;
        }
        if let foreground = foreground{
            attributes[.foregroundColor] = foreground;
        }
        
        self.init(string: string, attributes: attributes);
    }
    
    /**
        returns new mutable attributed string resized with given font size
        - parameter size: the font size to resize attributed string with
    */
    open func resize(withFontSize size: CGFloat) -> NSMutableAttributedString?{
        guard let styledText = self as? NSMutableAttributedString else{
            return self as? NSMutableAttributedString;
        }
        
        styledText.enumerateAttribute(.font, in: NSMakeRange(0, styledText.length), options: .longestEffectiveRangeNotRequired) { (value, range, canContinue) in
            guard let font = value as? UIFont else{
                return;
            }
            
            let newFont = font.withSize(size);
            let lineStyle = NSMutableParagraphStyle();
            //lineStyle.lineSpacing = 1.0;
            //lineStyle.lineHeightMultiple = self.lineHeight;
            styledText.addAttribute(.font, value: newFont, range: range);
            styledText.addAttribute(.paragraphStyle, value: lineStyle, range: range);
        }
        
        return styledText;
    }
    
    /**
         returns new mutable attributed string resized with given scale
         - parameter scale: the font scale to resize attributed string with
        - parameter lineSpacing: the line space to resize attributed string with
     */
    open func scale(_ scale: CGFloat, lineSpacing: CGFloat? = nil) -> NSMutableAttributedString?{
        let styledText = self as? NSMutableAttributedString ?? NSMutableAttributedString.init(attributedString: self)
        //print("styledText - \(styledText)");
        styledText.enumerateAttribute(.font, in: NSMakeRange(0, styledText.length), options: .longestEffectiveRangeNotRequired) { (value, range, canContinue) in
            if let font = value as? UIFont{
                let newFont = font.withSize(font.pointSize * scale);
                //if let spacing = lineSpacing{
                let lineStyle = NSMutableParagraphStyle();
                lineStyle.lineSpacing = font.lineHeight * scale * 0.5;
                styledText.addAttribute(.paragraphStyle, value: lineStyle, range: range);
                //}
                //lineStyle.lineHeightMultiple = self.lineHeight;
                styledText.addAttribute(.font, value: newFont, range: range);
            }else if let lineStyle = value as? NSMutableParagraphStyle, let spacing = lineSpacing{
                lineStyle.lineSpacing = spacing;
                styledText.addAttribute(.paragraphStyle, value: lineStyle, range: range);
            }
        }
        
        return styledText;
    }
    
    /// Returns mutable attributed string created with this
    func mutable() -> NSMutableAttributedString{
        return NSMutableAttributedString.init(attributedString: self);
    }
}
