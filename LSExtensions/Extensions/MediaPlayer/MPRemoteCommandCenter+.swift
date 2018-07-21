//
//  MPRemoteCommandCenter+.swift
//  pallyconswiftdemo
//
//  Created by 영준 이 on 2018. 6. 26..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation
import MediaPlayer

extension MPRemoteCommandCenter{
    /**
        Disables track commands and enables skip commands
    */
    public func showSkipCommands(){
        self.skipForwardCommand.isEnabled = true;
        self.skipBackwardCommand.isEnabled = true;
        self.previousTrackCommand.isEnabled = false;
        self.nextTrackCommand.isEnabled = false;
    }
}
