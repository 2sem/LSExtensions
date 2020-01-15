//
//  DispatchQueue+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2017. 7. 28..
//  Copyright © 2017년 leesam. All rights reserved.
//

import Foundation
import UIKit

extension DispatchQueue{
    /**
     Excute block in Main Thread synchronously
    */
    public func syncInMain(execute block: () -> Swift.Void){
        if Thread.isMainThread{
            block();
        }else{
            self.sync(execute: block);
        }
    }
    
    /**
     Submits a work item to a dispatch queue when condition is true and optionally associates it with a
     dispatch group. The dispatch group may be used to wait for the completion
     of the work items it references.
     - parameter group: the dispatch group to associate with the submitted
     work item. If this is `nil`, the work item is not associated with a group.
     - parameter flags: flags that control the execution environment of the
     - parameter qos: the QoS at which the work item should be executed.
     Defaults to `DispatchQoS.unspecified`.
     - parameter flags: flags that control the execution environment of the work item.
     - parameter execute: The work item to be invoked on the queue.
     - parameter when: Handler to check condition. if it is true, dispatch item will be submitted
     - parameter queue: Queue for performing condition handler
     - parameter interval: Interval to wait until next performing condition handler
     - parameter deadline: Limited time can check condition. If time is over it, dispatch work never be submitted
     - parameter work: Work Item
     - SeeAlso: `sync(execute:)`
     - SeeAlso: `DispatchQoS`
     - SeeAlso: `DispatchWorkItemFlags`
     */
    public func async(when: @escaping () -> Bool, queueForWhen queue: DispatchQueue? = nil, interval: TimeInterval = 0.1, deadline: DispatchTime? = nil, group: DispatchGroup? = nil, qos: DispatchQoS = .unspecified, flags: DispatchWorkItemFlags = [], execute work: @escaping @convention(block) () -> Void){
        let queue = queue ?? DispatchQueue.init(label: "async.when.queue", qos: qos);
        queue.async { [weak self] in
            func check() -> Bool{
                var value = false;
                self?.sync {
                    value = when();
                }
                
                return value;
            }
            
            while(!check()){
                if let deadline = deadline{
                    guard DispatchTime.now() < deadline else{
                        return;
                    }
                }
                
                Thread.sleep(forTimeInterval: interval);
            }
            
            self?.async(group: group, qos: qos, flags: flags, execute: {
                work();
            })
        }
    }
}
