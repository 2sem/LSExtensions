//
//  ArraySlice+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2020/10/24.
//  Copyright © 2020 leesam. All rights reserved.
//

import Foundation

extension ArraySlice where Element : Equatable  {
    /**
         Returns new array except duplicated elements
         - Parameter comparer: Handler to check if the two elements are same -- useless
         - parameter left : first element to be compared
         - parameter right : second element to be compared
     */
    public func distinct(_ comparer: ((_ left : Element, _ right : Element) -> Bool)? = nil) -> [Element]{
        return self.reduce(into: [Element](), { (result, element) in
            if let comparer = comparer{
                let isContain = result.contains(where: { comparer(element, $0) });
                guard !isContain else{
                    return;
                }
            }else{
                guard !result.contains(element) else{
                    return;
                }
            }
            result.append(element);
        });
    }
}
