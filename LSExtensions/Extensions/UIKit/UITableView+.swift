//
//  UITableView+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 8. 4..
//  Copyright © 2018년 leesam. All rights reserved.
//

import UIKit

extension UITableView{
    /**
     Hides the line for the empty rows
     */
    public var hideExtraRows : Bool{
        get{
            return self.tableFooterView != nil;
        }
        set(value){
            self.tableFooterView = value ? UIView() : nil;
        }
    }
    
    /// Scroll to end row of this table
    /// - Parameter animated: indicator whether to animate scrolling
    open func scrollToEnd(_ animated: Bool = true){
        let count = self.numberOfRows(inSection: 0);
        guard count > 0 else{
            return;
        }
        
        self.scrollToRow(at: IndexPath.init(row: count - 1, section: 0), at: .bottom, animated: animated);
    }
    
    /// Reselect rows selected after reload
    /// - Parameter keepSelection: indicator whether to reselect after reload
    open func reloadData(_ keepSelection: Bool){
        guard keepSelection else{
            self.reloadData();
            return;
        }
        
        let indexPaths = self.indexPathsForSelectedRows;
        let newIndexPaths = indexPaths?.filter{ $0.section < self.numberOfSections && $0.row < self.numberOfRows(inSection: $0.section) }
        
        self.reloadData();
        newIndexPaths?.forEach { self.selectRow(at: $0, animated: false, scrollPosition: .none) };
    }
    
    /// Reselect rows selected after end updates
    /// - Parameter keepSelection: indicator whether to reselect after reload
    open func endUpdates(_ keepSelection: Bool){
        guard keepSelection else{
            self.endUpdates();
            return;
        }
        
        let indexPaths = self.indexPathsForSelectedRows;
        let newIndexPaths = indexPaths?.filter{ $0.section < self.numberOfSections && $0.row < self.numberOfRows(inSection: $0.section) }
        
        self.endUpdates();
        newIndexPaths?.forEach { self.selectRow(at: $0, animated: false, scrollPosition: .none) };
    }
}
