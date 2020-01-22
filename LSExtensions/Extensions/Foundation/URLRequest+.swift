//
//  URLRequest+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 10. 7..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension URLRequest{
    /**
         Property for body of POST Method to set or get parameters
     */
    public var postParams : [String : String]{
        get{
            return self.getPost();
        }
        
        set(value){
            self.setPost(params: value);
        }
    }
    
    /**
         Gets paramters for the POST Method
     */
    public func getPost(encoding: String.Encoding = .utf8) -> [String : String]{
        return (String.init(data: self.httpBody ?? Data(), encoding: .utf8)?
            .components(separatedBy: "&").reduce(into: [String : String](), { (dict, param) in
                var keyvalue = param.components(separatedBy: "=");
                
                guard keyvalue.count > 1 else{
                    return;
                }
                
                dict[keyvalue[0]] = keyvalue[1];
            })) ?? [:];
    }
    
    /**
         Sets paramters for the POST Method
     */
    public mutating func setPost(params: [String : String], encoding: String.Encoding = .utf8){
        self.httpBody = params.map{ "\($0)=\($1.replacingOccurrences(of: "&", with: "%26").replacingOccurrences(of: "+", with: "%2B").replacingOccurrences(of: "=", with: "%3D"))" }.joined(separator: "&").data(using: encoding);
    }
}
