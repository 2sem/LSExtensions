//
//  Decodable+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2021/02/01.
//  Copyright © 2021 leesam. All rights reserved.
//

import Foundation

extension Decodable{
    //let res = try JSONDecoder().decode(SWClientEmptyResponse.self, from: data);
    /// alias for JSONDecoder().decode
    /// - Parameter data: data to decode
    /// - Throws: decode error
    /// - Returns: return decoded instance
    public static func decode(json data: Data) throws -> Self{
        return try JSONDecoder().decode(self.self, from: data);
        //return try JSONDecoder().decode(self.self, from: data);
    }
}
