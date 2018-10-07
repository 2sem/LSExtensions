//
//  UILabel+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 9. 24..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension UILabel{
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
    
    /**
        Gets size of the text in this label
    */
    open var rectForText : CGRect{
        let label = UILabel.init(frame: CGRect.zero);
        label.numberOfLines = self.numberOfLines;
        label.font = self.font;
        label.text = self.text;
        label.sizeToFit();
        
        // + 5
        return CGRect.init(origin: label.bounds.origin, size: CGSize(width: label.bounds.width, height: label.bounds.height));
        //return (self.text as NSString?)?.boundingRect(with: self.bounds.size, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : self.font], context: nil) ?? CGRect.zero;
    }
}
