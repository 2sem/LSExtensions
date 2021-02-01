//
//  UITableViewController+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2021/01/31.
//  Copyright © 2021 leesam. All rights reserved.
//

import UIKit

extension UITableViewController{
    /// Select all rows
    /// - Parameter selectFirst: whether to call didSelctRowAt for first row if function didSelectRowAt is defined
    func selectAll(_ selectFirst : Bool = true){
        let count = self.tableView.numberOfRows(inSection: 0);
        guard count > 0 else{
            return;
        }
        
        let selectedIndexPaths = self.tableView?.indexPathsForSelectedRows ?? [];
        if selectedIndexPaths.count == count{
            selectedIndexPaths.forEach{ self.tableView.deselectRow(at: $0, animated: false) };
            if self.responds(to: #selector(UITableViewController.tableView(_:didDeselectRowAt:))){
                self.tableView(self.tableView, didDeselectRowAt: selectedIndexPaths.first!);
            }
        }else{
            let indexPaths = (0..<count).map{ IndexPath.init(row: $0, section: 0) };
            indexPaths.forEach{ self.tableView?.selectRow(at: $0, animated: false, scrollPosition: .none) };
            if self.responds(to: #selector(UITableViewController.tableView(_:didSelectRowAt:))){
                self.tableView(self.tableView, didSelectRowAt: indexPaths.first!);
            }
        }
    }
}
