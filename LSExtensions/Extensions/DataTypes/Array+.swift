//
//  Array+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2017. 8. 15..
//  Copyright © 2017년 leesam. All rights reserved.
//

import Foundation

extension Array{
    public var any : Bool{
        get{
            return !self.isEmpty;
        }
    }
    
    /**
        Indicates whether this contains any value fit to given condition
         - parameter predicate: Block to get condition with an element
         - returns: whether this contains any value fir to given condition
     */
    public func any(where predicate: (Element) throws -> Bool = { _ in true }) rethrows -> Bool{
        return self.first{ try! predicate($0) } != nil;
    }
    
    /**
        Returns new sequence containing n elements from begin of this
        - parameter n: elements count to put new sequence
        - returns: new sequence containing n elements from begin of this
    */
    public func takeFirst(_ n: Int) -> ArraySlice<Element>{
        return self.dropLast(Swift.max(self.count - n, 0));
    }
    
    /**
        Returns new sequence containing n elements from end of this
        - parameter n: elements count to put new sequence
        - returns: new sequence containing n elements from end of this
     */
    public func takeLast(_ n: Int) -> ArraySlice<Element>{
        return self.dropFirst(Swift.max(self.count - n, 0));
    }
    
    public var random : Element?{
        get{
            return self.takeRandom(1).first;
        }
    }
    
    /**
        Returns new sequence containing n elements randomally from this
         - parameter n: elements count to put new sequence
         - returns: new sequence containing n elements randomally from this
    */
    public func takeRandom(_ n:Int) -> ArraySlice<Element>{
        var values : ArraySlice<Element> = [];
        var valueSet : [Int] = [];
        for _ in 0..<Swift.min(n, self.count){
            var value : Element
            
            repeat{
                let index = Int(arc4random_uniform(UInt32(self.count)));
                value = self[index];
                if !valueSet.contains(index) {
                    values.append(value);
                    valueSet.append(index);
                    break;
                }
            }while(true);
        }
        
        return values;
    }
    
    /**
        Removes element from this and returns it
         - parameter item: element to remove from this
         - parameter predicate: block to check if two element are same
         - returns: element removed from this.
     */
    @discardableResult
    public mutating func remove(_ item : Element, where predicate: (Element, Element) throws -> Bool) rethrows -> Bool{
        var i = 0;
        var value : Bool = true;
        
        for element in self{
            if try predicate(element, item) {
                self.remove(at: i);
                value = false;
                break;
            }
            
            i = i + 1;
        }
        
        return value;
    }
    
    /**
        Suffles this array
         - parameter predicate: block to check if two element are same
    */
    public mutating func suffled(where predicate: (Element, Element) throws -> Bool) rethrows{
        self = try self.suffle(where: predicate);
    }
    
    /**
        Returns new array contaning suffled elements from this
         - parameter predicate: block to check if two element are same
         - returns: New array contaning suffled elements from this
    */
    public func suffle(where predicate: (Element, Element) throws -> Bool) rethrows -> [Element]{
        var values : [Element] = [];
        var copies = self;
        
        while(values.count < self.count){
            let value = copies.random;
            values.append(value!);
            try copies.remove(value!, where: predicate);
        }
        
        return values;
    }
    
    /**
         Returns new array except duplicated elements
         - Parameter comparer: Handler to check if the two elements are same -- useless
         - parameter left : first element to be compared
         - parameter right : second element to be compared
     */
    public func distinct(_ comparer: ((_ left : Element, _ right : Element) -> Bool)? = nil) -> [Element] where Element : Equatable{
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
    
    /// Splits Array into sub arrays with given size and range
    /// - Parameters:
    ///   - from: Start position to slice this array
    ///   - to: End position to slice this array
    ///   - size: Size of sub array
    /// - Returns: Sub arrays sliced with given size
    public func sliced(from: Index = 0, to: Index? = nil, size: Int) -> [[Element]] {
        return self.isEmpty ? [] : stride(from: from, to: to ?? self.endIndex, by: size).map {
            Array(self[$0 ... Swift.min($0.advanced(by: size), self.endIndex.advanced(by: -1))])
        };
    }
    
    /// Access element of array without crashing by out of bound
    /// - Parameter safe: Index to access element
    public subscript(safe index: Int) -> Element?{
        guard index >= 0 && index < self.count else{
            return nil;
        }
        
        return self[index];
    }
    
    /// fill all elements of array with given value
    /// - Parameter value: value to fill this array
    public mutating func fill(_ value: Element){
        self.enumerated().forEach { (element) in
            self[element.offset] = value;
        }
    }
}
