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
        Enum for kCAMediaTimingFunction
    */
    public enum TransitionTiming : Int{
        case `default`
        case easeIn
        case linear
        case easeOut
        case easeIntEaseOut
        
        static let functionNames : [CAMediaTimingFunctionName] = [.easeInEaseOut, .default, .easeIn, .linear, .easeOut, CAMediaTimingFunctionName.easeInEaseOut];
        var function: CAMediaTimingFunction{
            return CAMediaTimingFunction.init(name: TransitionTiming.functionNames[self.rawValue]);
        }
    }
    
    /**
        Convenience Constructor for CATransition
        Enables to specity options by code auto completion
    */
    public convenience init(_ type : CATransitionType, subType : CATransitionSubtype = .fromRight, timing : TransitionTiming = .default, duration: CFTimeInterval = 0.5) {
        self.init();
        self.duration = duration;
        self.type = type;
        self.subtype = subType;
        self.timingFunction = timing.function;
    }
}
