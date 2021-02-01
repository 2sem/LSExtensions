//
//  UITextView+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2021/02/01.
//  Copyright © 2021 leesam. All rights reserved.
//

import UIKit

extension UITextView{
    public static func fixBugForXCode112(){
        if #available(iOS 13.2, *){
            return;
        }
        
        let className = "_UITextLayoutView"
        var cls = objc_getClass(className);

        if cls == nil {
            cls = objc_allocateClassPair(UIView.self, className, 0);
            objc_registerClassPair(cls as! AnyClass);
        }
    }
    
    /**
        Parses and sets html as attributed text
        - parameter html: html to parse and sets as attributed text of the label
        - parameter encoding: the encoding of the string to parse html with
    */
    open func loadHtml(_ html : String, encoding: String.Encoding = .utf8){
        guard let data = html.data(using: encoding) else{
            return;
        }
        self.attributedText = try? NSAttributedString.init(data: data,
                                                           options: [.documentType : NSAttributedString.DocumentType.html, .characterEncoding : encoding.rawValue],
                                                           documentAttributes: nil);
    }
}
