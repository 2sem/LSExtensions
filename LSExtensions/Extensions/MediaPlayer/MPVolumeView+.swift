//
//  MPVolumeView+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 9. 24..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation
import MediaPlayer

extension MPVolumeView{
    /**
        the value of the volume view
    */
    open var value : Float{
        get{
            return (subviews.first(where: {$0 is UISlider}) as? UISlider)?.value ?? 0;
        }
        set(value){
            (subviews.first(where: {$0 is UISlider}) as? UISlider)?.value = value;
        }
    }
}
