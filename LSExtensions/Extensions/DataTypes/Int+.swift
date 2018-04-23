//
//  Int+.swift
//  realtornote
//
//  Created by 영준 이 on 2017. 7. 26..
//  Copyright © 2017년 leesam. All rights reserved.
//

import Foundation

extension Int{
    
    static let romans : [String] = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII"];
    static let lowerAlphas : [String] = (UnicodeScalar("a")!.value...UnicodeScalar("z")!.value)
        .compactMap { String(UnicodeScalar($0)!) };
    static let upperAlphas : [String] = (UnicodeScalar("A")!.value...UnicodeScalar("Z")!.value)
        .compactMap { String(UnicodeScalar($0)!) };
        /*["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
                             "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];*/
    /**
     The roman number sequenced by this value
        - Requires: Value should be less than 12(XII)
        - Note: value start from 1
    */
    public var roman : String{
        let list = type(of: self).romans;
        return list[self % list.count - 1];
    }
    
    /**
        The lower case alphabet sequenced by this value
         - Note: value start from 1
    */
    public var lowerAlpha : String{
        let list = type(of: self).lowerAlphas;
        return list[self % list.count - 1];
    }
    
    /**
     The upper case alphabet sequenced by this value
         - Note: value start from 1
     */
    public var upperAlpha : String{
        let list = type(of: self).upperAlphas;
        return list[self % list.count - 1];
    }
    
    /**
        The sequence of the specified lower case alpha.
         - Note: value start from 1('a' == 1)
    */
    public init(alpha: String) {
        var value = (type(of: self).lowerAlphas.index(of: alpha) ?? -1);
        if value < 0{
            value = (type(of: self).upperAlphas.index(of: alpha) ?? -1);
        }
        self = value + 1;
    }
    
    /**
        Converts this to Distance String and returns it
         - parameter maximumFractions: Fraction Digit Count
         - returns: this to Distance String converted from this
    */
    public func stringForDistance(_ maximumFractions: Int = 2) -> String{
        var value = "";
        
        if self < 1000{
            value = "\(self) m";
        }else{
            let numberFormat = NumberFormatter()
            numberFormat.numberStyle = NumberFormatter.Style.decimal;
            numberFormat.maximumFractionDigits = maximumFractions;
            
            let km = Double(self) / 1000.0;
            value = "\(numberFormat.string(from: NSNumber(value: km)) ?? "") km";
        }
        
        return value;
    }
}

extension Int32{
    /**
     The roman number sequenced by this value
        - Requires: Value should be less than 12(XII)
        - Note: value start from 1
     */
    public var roman : String{
        return Int(self).roman;
    }
    
    /**
     The lower case alphabet sequenced by this value
         - Note: value start from 1
     */
    public var lowerAlpha : String{
        return Int(self).lowerAlpha;
    }
    
    /**
     The upper case alphabet sequenced by this value
         - Note: value start from 1
     */
    public var upperAlpha : String{
        return Int(self).upperAlpha;
    }
}

extension Int16{
    /**
     The roman number sequenced by this value
         - Requires: Value should be less than 12(XII)
         - Note: value start from 1
     */
    public var roman : String{
        return Int(self).roman;
    }
    
    /**
     The lower case alphabet sequenced by this value
         - Note: value start from 1
     */
    public var lowerAlpha : String{
        return Int(self).lowerAlpha;
    }
    
    /**
     The upper case alphabet sequenced by this value
         - Note: value start from 1
     */
    public var upperAlpha : String{
        return Int(self).upperAlpha;
    }
}
