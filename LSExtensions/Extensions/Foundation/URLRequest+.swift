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
                let keyvalue = param.components(separatedBy: "=");
                
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
        self.httpBody = params.map{ "\($0)=\($1.addingPercentEncoding(withAllowedCharacters: CharacterSet.init(charactersIn: "&+=").inverted) ?? "")" }.joined(separator: "&").data(using: encoding);
    }
    
    /**
         Property for body of POST Method to set or get parameters
     */
    public var securePostParams : [String : [Character]]{
        @available(*, unavailable)
        get{
            return [:];
        }
        
        set(value){
            self.setPost(secureParams: value);
        }
    }
    
    /**
         Sets paramters for the POST Method
     */
    public mutating func setPost(secureParams params: [String : [Character]], encoding: String.Encoding = .utf8){
        guard !params.isEmpty else{
            return;
        }
        
        var characters = "&".map{ $0 } + params.map { (kv) -> [Character] in
            return kv.key.map{ $0 } + "=".map{ $0 } + kv.value.flatMap{ String($0).addingPercentEncoding(withAllowedCharacters: CharacterSet.init(charactersIn: "&+=").inverted) ?? "" };
        }.joined(separator: "&".map{ $0 });
        
        var bytes = characters.flatMap{ $0.utf8.map{ $0 as UInt8 } };
        self.httpBody?.append(contentsOf: bytes);
        self.httpBody = self.httpBody;
        
        characters.fill(.init(" "));
        bytes.fill(0);
    }
    
    public func mutable() -> NSMutableURLRequest?{
        guard let url = self.url else{
            return nil
        }
        
        let value = NSMutableURLRequest.init(url: url, cachePolicy: self.cachePolicy, timeoutInterval: self.timeoutInterval) ;
        value.allHTTPHeaderFields = self.allHTTPHeaderFields;
        value.httpMethod = self.httpMethod ?? "get";
        
        return value;
    }
}
