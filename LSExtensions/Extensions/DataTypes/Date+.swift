//
//  Date+.swift
//  siwonlectureroom
//
//  Created by 영준 이 on 2018. 7. 5..
//  Copyright © 2018년 siwonschool. All rights reserved.
//
import Foundation

extension Date {
    /**
        Mili Seconds of the date
    */
    public var miliSeconds : NSNumber{
        get{
            let ms = 1000.0;
            
            return NSNumber(value: self.timeIntervalSince1970 * ms);
        }
    }
    
    /**
         Makes mid night time with this date
     */
    public var midNight : Date{
        var components = Calendar.current.dateComponents(in: Calendar.current.timeZone, from: self);
        components.setValue(23, for: .hour);
        components.setValue(59, for: .minute);
        components.setValue(59, for: .second);
        components.setValue(999, for: .nanosecond);
        
        return Calendar.current.date(from: components)!;
    }
    
    /// Whether this date's year month day is equal to Date()'s year, month, day
    public var isToday : Bool{
        return self.zeroDate == Date().zeroDate;
    }
    
    /// alias for Date()
    public static var now : Date{
        return .init();
    }
    
    /// alias for 1970-01-01
    public static var min : Date{
        return Date.init(timeIntervalSince1970: 0);
    }
    
    /**
        Returns the formatted string with given date format
        - parameter format: Date format to make the formmated string with
     */
    public func toString(_ format : String = "yyyy-MM-dd HH:mm:ss") -> String{
        var value = "";
        let formatter = DateFormatter();
        formatter.dateFormat = format;
        
        value = formatter.string(from: self);
        
        return value;
    }
    
    /**
        Compares this date with given date
        - parameter date: The date to compare with
        - parameter components: The components of the date to use for date comparing
    */
    public func isEqual(date : Date, components: Set<Calendar.Component>) -> Bool{
        var value = true;
        let calendar = Calendar.current;
        
        let dateComponents = calendar.dateComponents(components, from: date);
        let targetComponents = calendar.dateComponents(components, from: self);
        for component in components{
            switch component{
            case .calendar:
                value = dateComponents.calendar == targetComponents.calendar;
                break;
            case .era:
                value = dateComponents.era == targetComponents.era;
            case .year:
                value = dateComponents.year == targetComponents.year;
            case .month:
                value = dateComponents.month == targetComponents.month;
            case .day:
                value = dateComponents.day == targetComponents.day;
            case .hour:
                value = dateComponents.hour == targetComponents.hour;
            case .minute:
                value = dateComponents.minute == targetComponents.minute;
            case .second:
                value = dateComponents.second == targetComponents.second;
            case .weekday:
                value = dateComponents.weekday == targetComponents.weekday;
            case .weekdayOrdinal:
                value = dateComponents.weekdayOrdinal == targetComponents.weekdayOrdinal;
            case .quarter:
                value = dateComponents.quarter == targetComponents.quarter;
            case .weekOfMonth:
                value = dateComponents.weekOfMonth == targetComponents.weekOfMonth;
            case .weekOfYear:
                value = dateComponents.weekOfYear == targetComponents.weekOfYear;
            case .yearForWeekOfYear:
                value = dateComponents.yearForWeekOfYear == targetComponents.yearForWeekOfYear;
            case .nanosecond:
                value = dateComponents.nanosecond == targetComponents.nanosecond;
            case .timeZone:
                value = dateComponents.timeZone == targetComponents.timeZone;
            default: break;
            }
            
            if !value{
                break;
            }
        }
        
        return value;
    }

    /**
        Returns of given component of this
    */
    public subscript(component: Calendar.Component) -> Int?{
        get{
            return Calendar.current.dateComponents(in: Calendar.current.timeZone, from: self).value(for: component)
        }
        mutating set(value){
            var components = Calendar.current.dateComponents(in: Calendar.current.timeZone, from: self);
            components.setValue(value, for: component);
            
            self = Calendar.current.date(from: components)!;
        }
    }
    
    /**
        Year of this date
    */
    public var year: Int{
        get{
            return Calendar.current.dateComponents([.year], from: self).year ?? 0;
        }
        
        mutating set(value){
            var components = Calendar.current.dateComponents(in: Calendar.current.timeZone, from: self);
            components.year = value;
            self = Calendar.current.date(from: components)!;
        }
    }
    
    /**
        Month of this date
    */
    public var month: Int{
        get{
            return Calendar.current.dateComponents([.month], from: self).month ?? 0;
        }
        
        mutating set(value){
            var components = Calendar.current.dateComponents(in: Calendar.current.timeZone, from: self);
            components.month = value;
            self = Calendar.current.date(from: components)!;
        }
    }
    
    /**
        Day of this date
    */
    public var day: Int{
        get{
            return Calendar.current.dateComponents([.day], from: self).day ?? 0;
        }
        
        mutating set(value){
            var components = Calendar.current.dateComponents(in: Calendar.current.timeZone, from: self);
            components.day = value;
            self = Calendar.current.date(from: components)!;
        }
    }
    
    /**
         Hour of this date
     */
    public var hour: Int{
        get{
            return Calendar.current.dateComponents([.hour], from: self).hour ?? 0;
        }
        
        mutating set(value){
            var components = Calendar.current.dateComponents(in: Calendar.current.timeZone, from: self);
            components.hour = value;
            self = Calendar.current.date(from: components)!;
        }
    }
    
    /**
        Makes zero hour date with this date
    */
    public var zeroDate : Date{
        var components = Calendar.current.dateComponents(in: Calendar.current.timeZone, from: self);
        components.setValue(0, for: .hour);
        components.setValue(0, for: .minute);
        components.setValue(0, for: .second);
        components.setValue(0, for: .nanosecond);
        
        return Calendar.current.date(from: components)!;
    }

    /**
        start day of this month
    */
    public var startOfMonth : Date{
        return DateComponents(year: self.year, month: self.month, day: 1).date!;
        /*guard self.day > 1 else{
            return self.zeroDate
        }
        
        var daycomp = DateComponents.init(day: 1);
        var lastMonth Calendar.current.date(byAdding: <#T##DateComponents#>, to: <#T##Date#>)*/
        
    }
    
    /**
        The same day of next month
    */
    public var nextMonth : Date?{
        return Calendar.current.date(byAdding: .month, value: 1, to: self);
    }
    
    /**
         The same day of last month
     */
    public var lastMonth : Date?{
        return Calendar.current.date(byAdding: .month, value: -1, to: self);
    }
    
    /**
        The date after given component
    */
    //Calendar.current.date(byAdding component: Calendar.Component, value: Int, to date: Date, wrappingComponents: Bool = default)
    public func adding(by component: Calendar.Component, value: Int) -> Date?{
        return Calendar.current.date(byAdding: component, value: value, to: self);
    }
}
