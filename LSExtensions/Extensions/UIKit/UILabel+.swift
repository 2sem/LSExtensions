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
}
