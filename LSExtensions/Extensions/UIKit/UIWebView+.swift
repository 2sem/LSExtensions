//
//  UIWebView+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 10. 7..
//  Copyright © 2018년 leesam. All rights reserved.
//

import UIKit

extension UIWebView {
    func fitToWidth(){
        self.stringByEvaluatingJavaScript(from: "document.querySelector('meta[name=viewport]').setAttribute('content', 'width=\(self.frame.size.width);', false);");
    }
    
    func fitToSize(){
        self.stringByEvaluatingJavaScript(from: "document.querySelector('meta[name=viewport]').setAttribute('content', 'width=\(self.frame.size.width);height=\(self.frame.size.height);', false);");
    }
}
