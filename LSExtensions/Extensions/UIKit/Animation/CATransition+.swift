//
//  CATransition+.swift
//  siwonlectureroom
//
//  Created by 영준 이 on 2018. 7. 3..
//  Copyright © 2018년 siwonschool. All rights reserved.
//

import UIKit

extension CATransition{
    /**
        Enum for kCATransition
    */
    public enum TransitionType : Int{
        case fade, moveIn, push, reveal
        
        static let strings : [String] = [kCATransitionFade, kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal];
        var string : String{
            return TransitionType.strings[self.rawValue];
        }
    }
    
    /**
        Enum for kCATransitionFrom
    */
    public enum TransitionSubType: Int{
        case fromRight, fromLeft, fromTop, fromBottom
        
        static let strings : [String] = [kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom];
        var string : String{
            return TransitionSubType.strings[self.rawValue];
        }
    }
    
    /**
        Enum for kCAMediaTimingFunction
    */
    public enum TransitionTiming : Int{
        case `default`
        case easeIn
        case linear
        case easeOut
        case easeIntEaseOut
        
        static let functionNames : [String] = [kCAMediaTimingFunctionEaseInEaseOut, kCAMediaTimingFunctionDefault, kCAMediaTimingFunctionEaseIn, kCAMediaTimingFunctionLinear, kCAMediaTimingFunctionEaseOut, kCAMediaTimingFunctionEaseInEaseOut];
        var function: CAMediaTimingFunction{
            return CAMediaTimingFunction.init(name: TransitionTiming.functionNames[self.rawValue]);
        }
    }
    
    /**
        Convenience Constructor for CATransition
        Enables to specity options by code auto completion
    */
    public convenience init(_ type : TransitionType, subType : TransitionSubType = .fromRight, timing : TransitionTiming = .default, duration: CFTimeInterval = 0.5) {
        self.init();
        self.duration = duration;
        self.type = type.string;
        self.subtype = subType.string;
        self.timingFunction = timing.function;
    }
}
