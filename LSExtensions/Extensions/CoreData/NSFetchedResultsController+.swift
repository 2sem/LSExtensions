//
//  NSFetchedResultsController+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2019. 1. 24..
//  Copyright © 2019년 leesam. All rights reserved.
//

import Foundation
import CoreData

extension NSFetchedResultsController{
    @objc public convenience init(managedObjectContext context: NSManagedObjectContext, delegate: NSFetchedResultsControllerDelegate? = nil, entityName: String, predicate: NSPredicate? = nil, sortKeys: [NSSortDescriptor]) {
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: entityName);
        request.sortDescriptors = sortKeys;
        self.init(fetchRequest: request as! NSFetchRequest<ResultType>, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil);
        self.delegate = delegate;
        self.fetchRequest.predicate = predicate;
    }
    
    @objc public func count(section : Int = 0) -> Int{
        return self.sections?[section].numberOfObjects ?? 0;
    }
}
