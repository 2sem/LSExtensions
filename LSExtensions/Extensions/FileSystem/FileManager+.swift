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
    public static var documents: [URL]{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask);
    }
}
