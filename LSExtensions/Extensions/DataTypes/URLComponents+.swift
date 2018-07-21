//
//  URLComponents+.swift
//  pallyconswiftdemo
//
//  Created by 영준 이 on 2018. 6. 29..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension URLComponents{
    /**
        Search the query value by given query name
        - parameter name: Query name to get
    */
    public subscript(name: String) -> String?{
        get{
            return self.queryItems?.first(where: { $0.name == name })?.value ?? nil;
        }
        set(value){
            var item = self.queryItems?.first(where: { $0.name == name });
            if item == nil{
                item = URLQueryItem.init(name: name, value: value);
                self.queryItems = self.queryItems ?? [];
                self.queryItems?.append(item!);
            }else{
                item?.value = value;
            }
        }
    }
}
