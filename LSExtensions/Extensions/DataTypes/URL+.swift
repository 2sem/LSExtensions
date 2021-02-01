//
//  URL+.swift
//  pallyconswiftdemo
//
//  Created by 영준 이 on 2018. 6. 29..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension URL{
    /**
        Indicator whether this is web url or not
         True: web url, otherwise is not
    */
    public var isWebURL : Bool{
        return ["http", "https"].contains(self.scheme?.lowercased() ?? "");
    }
    
    /**
        Indicator whether this path is a exist file
    */
    public var isExist : Bool{
        return FileManager.default.fileExists(atPath: self.path);
    }
    
    /**
        copies file located at this to given url
        - parameter url: the url destination to copy this file
        - parameter overwrite: indication whether to overwrite destination is already exist
    */
    public func copy(_ url: URL, overwrite : Bool) throws{
        let mng = FileManager.default;
        if overwrite, mng.fileExists(atPath: url.path){
            try mng.removeItem(at: url);
        }
        
        try mng.copyItem(at: self, to: url);
    }
    
    /** Removes file which is exist at this URL if it is local file
     - Parameter withSubFiles: Whether to remove sub files constained in this url
    */
    public func delete(_ withSubFiles: Bool = false ) throws{
        let files = try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil)
        for file in files{
            try file.delete(withSubFiles);
        }
        try FileManager.default.removeItem(at: self);
    }
}
