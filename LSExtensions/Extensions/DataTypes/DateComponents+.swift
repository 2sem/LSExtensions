//
//  DateComponents+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 7. 28..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension DateComponents{
    
    /**
        Creates DateComponents with hour and minute
        - parameter hour : hour to set for new DateComponents
        - parameter minute: minute to set for new DateComponents
    */
    init(hour : Int, minute : Int) {
        self.init();
        self.hour = hour;
        self.minute = minute;
    }
    
    /**
        Convenient Enum for weekday
        weekday is Int, so developer couldn't set it easily
    */
    public struct DateWeekDay : OptionSet{
        public var rawValue : Int;
        
        public init(rawValue: Int) {
            self.rawValue = rawValue;
        }
        
        static let Sunday = DateWeekDay.init(rawValue: 1);
        static let Monday = DateWeekDay.init(rawValue: 1 << 1);
        static let Tuesday = DateWeekDay.init(rawValue: 1 << 2);
        static let Wednesday = DateWeekDay.init(rawValue: 1 << 3);
        static let Thursday = DateWeekDay.init(rawValue: 1 << 4);
        static let Friday = DateWeekDay.init(rawValue: 1 << 5);
        static let Saturday = DateWeekDay.init(rawValue: 1 << 6);
        public static let All : DateWeekDay = [.Sunday, .Monday, .Tuesday, .Wednesday, .Thursday, .Friday, .Saturday];
        public static let allWeekDays : [DateWeekDay] = [DateWeekDay.Sunday, DateWeekDay.Monday, DateWeekDay.Tuesday, DateWeekDay.Wednesday, DateWeekDay.Thursday, DateWeekDay.Friday, DateWeekDay.Saturday];
        //static let strings : [String] = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"];
        static let strings : [String] = ["일", "월", "화", "수", "목", "금", "토"];
        
        /**
            Weekdays contained in this week day set
        */
        public var days : [DateWeekDay]{
            get{
                return DateWeekDay.allWeekDays.filter({ (weekday) -> Bool in
                    return self.intersection(weekday) == weekday;
                })
            }
        }
        
        /**
            Description of this week day set
        */
        public var string : String{
            get{
                var value = "";
                
                if self == DateComponents.DateWeekDay.All{
                    value = "매일";
                }else if self.days.count > 1{
                    value = self.days.map({ (day) -> String in
                        return day.string;
                    }).joined(separator: ",");
                }else if let day = self.days.first{
                    value = DateWeekDay.strings[DateWeekDay.allWeekDays.index(of: day) ?? 0];
                }
                
                //return DateWeekDay.strings[DateWeekDay.allWeekDays.index(of: self) ?? 0];
                return value;
            }
        }
        
        /**
            Raw value of week day set
        */
        public var weekday : Int{
            get{
                return (DateWeekDay.allWeekDays.index(of: self) ?? 0) + 1;
            }
        }
    }
    
    /**
        Week day set converted from raw weekday
    */
    public var weekDay : DateWeekDay?{
        get{
            var value : DateWeekDay?;
            
            if self.weekDay != nil{
                value = DateWeekDay.allWeekDays[self.weekday! - 1];
            }
            return value;
        }
        
        set(value){
            if value == nil{
                self.weekday = nil;
            }else{
                self.weekday = (DateWeekDay.allWeekDays.index(of: value!) ?? 0) + 1;
            }
        }
    }
    
    /**
        Subtracts given minutes from this
        - parameter minutes: Minutes to subtract from this
        - note: this function doesn't decrease day. decreasing will perform with only time values
    */
    public mutating func decreaseMinutes(_ minutes : Int){
        guard self.minute != nil else{
            return;
        }
        
        self.minute = self.minute! - minutes;
        if self.minute! < 0{
            if self.hour != nil{
                self.hour = self.hour! - 1;
                if self.hour! < 0{
                    self.hour = 23;
                }
            }
            self.minute = 60 + self.minute!;
        }
    }
    
    /**
        Returns new DateComponents with subtracted given minutes from this
        - parameter minutes: Minutes to subtract from this
        - returns: new DateComponents with subtracted given minutes from this
        - note: this function doesn't decrease day. decreasing will perform with only time values
    */
    public func decreasingMinutes(_ minutes: Int) -> DateComponents{
        var value = self;
        value.decreaseMinutes(minutes);
        
        return value;
    }
    
    /**
        Time description for this DateComponents
    */
    public var timeString : String{
        get{
            var value = "";
            
            var date = self;
            let hour = date.hour! > 12 ? date.hour! - 12 : date.hour!;
    
            value.append(" \(date.hour == nil ? "매시" : (date.hour! >= 12 ? "오후" : "오전") + " \(hour)시" )");
            value.append(date.minute! <= 0 ? " 정각" : " \(date.minute!)분");
            
            return value;
        }
    }
    
    /**
         TimeInterval(Seconds) generated with hour, minute, second of this DateComponents
     */
    public var time : TimeInterval{
        var value = (self.hour ?? 0) * 60 * 60;
        value += (self.minute ?? 0) * 60;
        value += (self.second ?? 0);
        return TimeInterval(value);
    }
}
