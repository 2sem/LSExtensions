//
//  FileManager+.swift
//  pallyconswiftdemo
//
//  Created by 영준 이 on 2018. 6. 29..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension FileManager{
    /**
        Short cut for FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    */
    open static var documents: [URL]{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask);
    }
    
    /**
        Copies target file to destination url
    */
    func copyItem(at: URL, to: URL, overwrite : Bool) throws{
        if overwrite{
            if self.fileExists(atPath: to.path){
                try self.removeItem(at: to);
            }
        }
        
        try self.copyItem(at: at, to: to);
    }
}
