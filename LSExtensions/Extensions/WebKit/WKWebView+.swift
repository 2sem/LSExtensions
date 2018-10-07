//
//  WKWebView+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 10. 7..
//  Copyright © 2018년 leesam. All rights reserved.
//

import WebKit

extension WKWebView {
    public func fitToWidth(){
        self.evaluateJavaScript("document.querySelector('meta[name=viewport]').setAttribute('content', 'width=\(self.frame.size.width);', false);", completionHandler: nil);
    }
    
    public func fitToSize(){
        self.evaluateJavaScript("document.querySelector('meta[name=viewport]').setAttribute('content', 'width=\(self.frame.size.width);height=\(self.frame.size.height);', false);", completionHandler: nil);
    }
}
