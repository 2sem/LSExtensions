//
//  UITableViewCell+.swift
//  siwonlectureroom
//
//  Created by 영준 이 on 2018. 7. 5..
//  Copyright © 2018년 siwonschool. All rights reserved.
//

import UIKit

extension UITableViewCell{
    /**
        Copy style of this cell to given cell
        - parameter cell: Target cell to copy style
    */
    public func copyStyle(to cell: UITableViewCell){
        cell.backgroundColor = self.backgroundColor;
        cell.tintColor = self.tintColor;
        cell.accessoryType = self.accessoryType;
        //cell.editingStyle = self.editingStyle;
        cell.focusStyle = self.focusStyle;
        cell.selectionStyle = self.selectionStyle;
        cell.separatorInset = self.separatorInset;
        
        cell.textLabel?.tintColor = cell.textLabel?.tintColor;
        cell.textLabel?.backgroundColor = cell.textLabel?.backgroundColor;
        cell.textLabel?.textColor = cell.textLabel?.textColor;
        cell.textLabel?.shadowColor = cell.textLabel?.shadowColor;
        cell.textLabel?.highlightedTextColor = cell.textLabel?.highlightedTextColor;
        cell.textLabel?.borderUIColor = cell.textLabel?.borderUIColor;
        cell.textLabel?.font = cell.textLabel?.font;
    }
}
