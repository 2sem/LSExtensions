//
//  UIBarButtonItem+.swift
//  siwonlectureroom
//
//  Created by 이영준 on 2018. 7. 13..
//  Copyright © 2018년 siwonschool. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    /**
        Generates new flexible space item
    */
    public static var flexibleSpace : UIBarButtonItem{
        return UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil);
    }
}
