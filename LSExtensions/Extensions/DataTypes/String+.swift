//
//  String+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2016. 3. 11..
//  Copyright © 2016년 leesam. All rights reserved.
//

import UIKit

extension String {
    /**
     Indicates whether this have any value(= not empty)
    */
    public var any : Bool{
        get{
            return !self.isEmpty;
        }
    }
    
    /**
        Gets Localized String by specified Locale
        - parameter defaultText: default String if there is no localized string for this
        - parameter locale: Locale to get localized String with
        - returns: Localized String by specified Locale
    */
    public func localized(_ defaultText : String? = nil, locale: Locale? = Locale.current) -> String{
        var value = self;
        var bundlePath : String? = Bundle.main.path(forResource: locale?.identifier, ofType: "lproj");
        if bundlePath == nil{
            bundlePath = Bundle.main.path(forResource: locale?.languageCode, ofType: "lproj");
        }
        if bundlePath == nil{
            bundlePath = Bundle.main.path(forResource: "\(locale?.languageCode ?? "")-\(locale?.scriptCode ?? "")", ofType: "lproj");
        }
        
        //Check if specified lang equals to base lang
        if bundlePath == nil && locale?.languageCode == "en"{
            bundlePath = Bundle.main.path(forResource: nil, ofType: "lproj");
        }
        
        if bundlePath == nil{
            value = NSLocalizedString(defaultText ?? self, comment: "");
        }else{
            let bundle = Bundle(path: bundlePath!)!;
            
            value = bundle.localizedString(forKey: self, value: defaultText ?? self, table: nil);
        }
        
        return value;
    }

    /**
     Indicates whether this contains Korean Character
    */
    public func containsKorean() -> Bool{
        return self.first{ $0.isKorean() } != nil;
    }
    
    /**
     Gets String generated with Cho Seong Characters of this String.
     - parameter double2One: Indicate whether make two cho seong to single.
    */
    public func getKoreanChoSeongs(_ double2One : Bool = true) -> String?{
        var value : String = "";
        
        guard self.containsKorean() else {
            return value;
        }
        
        var noKorean = true;
        var lastCho = "";
        //go through characters of this
        for char in self{
            var cho = char.getKoreanChoseong();
            
            if double2One && cho != nil{
                let doubleCho = lastCho.getMergeKoreanChoseong(cho!);
                if !doubleCho.isEmpty{
                    //remove cho seong before this cho seong
                    //value.replaceSubrange((value.index(value.endIndex, offsetBy: -1) ..< value.endIndex), with: "");
                    value.remove(at: value.index(before: value.endIndex));
                    cho = doubleCho;
                }
            }
            
            value += cho != nil ? cho! : (noKorean ? "" : " ");
            noKorean = cho == nil;
            
            lastCho = cho ?? "";
//            var singleString = String(char);
//            var scalars = singleString.unicodeScalars;
//            var scalarString = "";
//            
//            for scalar in scalars{
//                scalarString = String(format:"%X ", scalar.value);
//            }
//            NSLog("[\(i)] \(char) hash[\(char.hashValue)] scalar[\(scalarString)]");
        }
        
        //어 : C5B4 = ㅇ(U+3147) + ㅓ(U+3153)
        //hangul jungseong - begin - ㅏ(U+314F) 1161
        //가(U+AC00) = ㄱ(U+3131, U+1100, U+11A8)
        //각(U+AC01) =
        //아(U+C544) = ㅇ(U+3147) + ㅏ(U+314F, U+1161)
        //NSLog("###### \(value) ######");
        return value;
    }
    
    /**
     Gets String merged given cho seong with Cho Seong Character of this String.
     - parameter double2One: Indicate whether make two cho seong to single.
     - returns: double cho seong if given cho seong is same to this cho seong.
     */
    func getMergeKoreanChoseong(_ targetChoseong : String) -> String{
        var value = "";
        
        switch(self){
            case "ㄱ":
                if targetChoseong == "ㄱ"{
                    value = "ㄲ";
                }
                break;
            case "ㄷ":
                if targetChoseong == "ㄷ"{
                    value = "ㄸ";
                }
                break;
            case "ㅂ":
                if targetChoseong == "ㅂ"{
                    value = "ㅃ";
                }
                break;
            case "ㅅ":
                if targetChoseong == "ㅅ"{
                    value = "ㅆ";
                }
                break;
            case "ㅈ":
                if targetChoseong == "ㅉ"{
                    value = "ㅉ";
                }
            break;
            default:
                break;
        }
        
        return value;
    }
    
    /**
        Gets Korean Parts(cho seong, jung seong, jong seong) of this
        - parameter double2One: Indicate whether make two cho seong to single.
    */
    public func getKoreanParts(_ double2One : Bool = true) -> String?{
        var value : String = "";
        
        guard self.containsKorean() else {
            return value;
        }
        
        self.forEach({ value += $0.getKoreanParts() })
        
        //어 : C5B4 = ㅇ(U+3147) + ㅓ(U+3153)
        //hangul jungseong - begin - ㅏ(U+314F) 1161
        //가(U+AC00) = ㄱ(U+3131, U+1100, U+11A8)
        //각(U+AC01) =
        //아(U+C544) = ㅇ(U+3147) + ㅏ(U+314F, U+1161)
        //NSLog("###### \(value) ######");
        return value;
    }

    /**
        Count of characters
    */
    public var length : Int{
        get{
            return self.count;
        }
    }
    
    /**
        Gets string removed empty spaces
        - returns: string removed empty spaces
    */
    public func trim() -> String{
        return self.trimmingCharacters(in: CharacterSet.whitespaces);
    }

    /**
        Returns indicate whether this is Hex String
         - returns: indicates whether this is Hex String
    */
    public func isHex() -> Bool{
        var value = self.length > 0;
        let hexStrings = "abcdef0123456789";
        let lower = self.lowercased();
        
        value = lower.first{ !hexStrings.contains($0) } == nil;
        
        return value;
    }
    
    /**
        Returns UIColor generated with this color value
     - requires: this should be formated '#aarrggbb' or '#rrggbb' or 'aarrggbb' or 'rrggbb'
    */
    public func toUIColor() -> UIColor?{
        var value : UIColor?;
        let colorString = self.trim();
        
        guard colorString.length >= 6 else{
            return value;
        }
        
        var index = self.startIndex;
        
        //skip #
        if self[index] == "#"  {
            index = self.index(index, offsetBy: 1);
        }
        
        let length = self[index...].count;
        guard length >= 6 else {
            return value;
        }
        
        do{
            //parse each 2 characters
            let rString = String(self[index..<self.index(index, offsetBy: 2)]);
            index = self.index(index, offsetBy: 2);
            
            let gString = String(self[index..<self.index(index, offsetBy: 2)]);
            index = self.index(index, offsetBy: 2);
            
            let bString = String(self[index..<self.index(index, offsetBy: 2)]);
            
            var aString = "";
            if length > 6 {
                index = self.index(index, offsetBy: 2);
                
                aString = String(self[index..<self.index(index, offsetBy: 2)]);
            }
            
            //checks if string is hex string to avoid fatalError
            if !rString.isHex(){
                throw StringExtensionError.invalidHex("[\(rString)] is not hex string.");
            }
            
            if !gString.isHex(){
                throw StringExtensionError.invalidHex("[\(gString)] is not hex string.");
            }
            
            if !bString.isHex(){
                throw StringExtensionError.invalidHex("[\(bString)] is not hex string.");
            }
            
            var alpha : CGFloat = 1.0;
            //faltalError will be raised if string is not hex string
            let rValue = CGFloat(Int(rString, radix: 16)!) / 255.0;
            let gValue = CGFloat(Int(gString, radix: 16)!) / 255.0;
            let bValue = CGFloat(Int(bString, radix: 16)!) / 255.0;
            
            if aString.any && aString.isHex(){
                alpha = CGFloat(Int(aString, radix: 16)!) / 255.0;
            }
            
            value = UIColor(red: rValue, green: gValue, blue: bValue, alpha: alpha);
            print("create color[\(value?.description ?? "")] with [\(self)]");
        }catch let error{
            print("invalid color value[\(self)] error[\(error)]");
        }
        
        return value;
    }
    
    /**
         Returns the Date created by this
         - parameter format: date format to parse
         - parameter timezone: TimeZone of the date to be returned
         - requires: this should be formated given format
         - returns: The date created by this
    */
    public func toDate(_ format : String = "yyyy-MM-dd'T'HH:mm:ssZZZZ", timezone: TimeZone? = TimeZone(identifier: "Asia/Seoul")) -> Date?{
        let formatter = DateFormatter();
        formatter.dateFormat = format;
        formatter.timeZone = timezone;
        
        return formatter.date(from: self);
    }
    
    /**
        Returns the indicate whether this is passed validation by given pattern
         - parameter pattern: pattern to validate this with
    */
    public func validate(_ pattern : String) -> Bool{
        var value = false;
        do{
            let rex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0));
            let range = NSMakeRange(0, self.length);
            let match = rex.firstMatch(in: self, options: .reportProgress, range: range);
            value = (match?.range.location ?? NSNotFound) != NSNotFound;
            //print("string validate. string[\(self)] => result[\(value)]. match[\(match)]", terminator: "\n");
        }catch(let error){
            print("string validation error[\(error) string[\(self)]]")
        }
        
        return value;
    }
    
    /**
        Returns the dictionary generated by parsing this with given pattern
         - parameter pattern: pattern to parse this
         - returns: the dictionary generated by parsing this with given pattern
    */
    public func parse(_ pattern : String) -> [Int : String]{
        var values : [Int : String] = [:];
        do{
            let rex = try NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators);
            //let range = NSMakeRange(0, self.length);
            //let match = rex.firstMatch(in: self, options: .reportProgress, range: range);
            //print("parse string. string[\(self)] pattern[\(pattern)]");
            let match = rex.firstMatch(in: self, options: .reportCompletion, range: self.fullRange);
            print("matches components[\(match?.components?.description ?? "")] range[\(match?.numberOfRanges.description ?? "")]");
            
            guard match != nil else{
                return values;
            }
            
            for index in 0..<match!.numberOfRanges{
                let range = match!.range(at: index);
                values[index] = (self as NSString).substring(with: range);
                
                print("matches index[\(index.description)] location[\(range.location.description)] length[\(range.length.description)] text[\(values[index]?.description ?? "")]");
            }
            /*rex.matches(in: self, options: .reportProgress, range: self.fullRange).forEach({ (result) in
                print("matches components[\(result.components)] range[\(result.rangeAt(1).location)] range[\(result.rangeAt(2).location)]");
                result.components?.forEach({ (key, value) in
                    values[key] = value;
                })
            })*/
            //value = (match?.range.location ?? NSNotFound) != NSNotFound;
            //print("string validate. string[\(self)] => result[\(value)]. match[\(match)]", terminator: "\n");
        }catch let error{
            print("string validation error[\(error) string[\(self)]]")
        }
        
        return values;
    }
    
    /**
     Indicates whether this is file name
    */
    public var isFileName : Bool{
        get{
            return self.validate("^[\\w\\s~\\!@#\\$%\\^&\\(\\)\\+\\-=\\{\\}\\[\\];\",\\.]+$");
        }
    }
    
    /**
        Full Range of this
    */
    public var fullRange : NSRange{
        get{
            return NSMakeRange(0, self.length);
            //return NSRange.init(location: 0, length: self.characters.count);
        }
    }
    
    /**
        Returns new string generated this repeated given number of times.
         - parameter count: Repeating count
         - returns: New string generated this repeated given number of times.
    */
    public func multiply(_ count : Int) -> String{
        return String.init(repeating: self, count: count);
    }
    
    /**
        Url to search by Naver with this string
     */
    public var naverUrlForSearch : URL{
        return URL(string: "http://search.naver.com/search.naver?ie=utf8&query=\(self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")")!;
    }
}

enum StringExtensionError : Error{
    /**
        Error to indicate that String is not Hex formated
     */
    case invalidHex(String);
}
