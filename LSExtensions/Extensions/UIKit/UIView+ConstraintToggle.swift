//
//  UIView+ConstraintToggle.swift
//  siwonlectureroom
//
//  Created by 이영준 on 2018. 7. 18..
//  Copyright © 2018년 siwonschool. All rights reserved.
//

import UIKit


extension UIView{
    /**
        Register two layout constraints to toggle layout with it later
        - parameter key: toggle key
        - parameter constraintForOn: constraint to active when toggle has been on
        - parameter constraintForOff: constraint to active when toggle has been off
    */
    public func registerToggleConstraints(_ key: String, constraintForOn on: [NSLayoutConstraint], constraintForOff off: [NSLayoutConstraint]){
        var constraints = self._constraintsForToggle;
        constraints[key] = [true: on, false: off];
        
        print("add constraint for toggle. constraints[\(constraints)]");
        _set_constraintsForToggle(constraints);
    }
    
    /**
        Toggles layout with toggle key and switch value(on/off)
        - parameter key: toggle key
        - parameter isOn: whether toggle is on. true is on, otherwise is off
        - parameter animated: whether toggle with animation
        - parameter duration: animation duration
    */
    public func togglesConstraint(_ key: String, isOn on: Bool, animated: Bool = true, duration: TimeInterval = 0.3){
        guard let constraints = self._constraintsForToggle[key] else{
            print("there is no constraint for toggle. key[\(key)]");
            return;
        }
        
        let constraintsForOn = constraints[true] ?? [];
        let constraintsForOff = constraints[false] ?? [];
        NSLayoutConstraint.deactivate(on ? constraintsForOff : constraintsForOn);
        NSLayoutConstraint.activate(on ? constraintsForOn : constraintsForOff);
        print("toggle with constraints. key[\(key)] on[\(constraintsForOn)] off[\(constraintsForOff)]");
        
        if animated{
            UIView.animate(withDuration: duration) { [weak self] in
                self?.layoutIfNeeded();
            }
        }

    }
    
    /**
        Clear registered constraints for toggle
        - parameter key: toggle key to clear constraints
    */
    public func clearConstraintsForToggle(_ key: String? = nil){
        //clear associated property?
        guard let key = key else{
            //clear all constraints if key is not specified
            self.setObjcProperty(&constraintToggleKey.associatedKey, value: nil, policy: .OBJC_ASSOCIATION_COPY);
            return;
        }
        
        var constraints = self._constraintsForToggle;
        constraints[key] = nil;
        
        print("remove constraint for toggle. key[\(key)]");
        self._set_constraintsForToggle(constraints);
    }
}

extension UIView{
    fileprivate struct constraintToggleKey{
        static var associatedKey = "";
    }
    fileprivate var _constraintsForToggle : [String : [Bool:[NSLayoutConstraint]]]{
        var value = objc_getAssociatedObject(self, &constraintToggleKey.associatedKey) as? [String : [Bool:[NSLayoutConstraint]]];
        guard value == nil else{
            return value!;
        }
        value = [:];
        self._set_constraintsForToggle(value!);
        
        return value!;
    }
    fileprivate func _set_constraintsForToggle(_ value: [String : [Bool:[NSLayoutConstraint]]]){
        self.setObjcProperty(&constraintToggleKey.associatedKey, value: value, policy: .OBJC_ASSOCIATION_COPY);
    }
}
