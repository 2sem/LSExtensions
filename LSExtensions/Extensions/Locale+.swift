//
//  Locale+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2018. 4. 21..
//  Copyright © 2018년 leesam. All rights reserved.
//

import Foundation

extension Locale{
    /**
     Indication whether this is korean locale?
    */
    public var isKorean : Bool{
       return self.identifier.hasPrefix("ko");
    }
    
    /**
     Indication whether this is english locale?
     */
    public var isEnglish : Bool{
        get{
            return self.identifier.hasPrefix("en");
        }
    }
    
    /**
     Indication whether this is chinese - traditional locale?
     */
    public var isChineseTraditional : Bool{
        get{
            return self.identifier.hasPrefix("zh-Hant");
        }
    }
    
    /**
     Indication whether this is chinese - simple locale?
     */
    public var isChineseSimple : Bool{
        get{
            return self.identifier.hasPrefix("zh-Hans");
        }
    }
    
    /**
     Indication whether this is german locale?
     */
    public var isGerman : Bool{
        get{
            return self.identifier.hasPrefix("de");
        }
    }
    
    /**
     Indication whether this is japanese locale?
     */
    public var isJapanease : Bool{
        get{
            return self.identifier.hasPrefix("ja");
        }
    }
    
    /**
     Indication whether this is spanish locale?
     */
    public var isSpanish : Bool{
        get{
            return self.identifier.hasPrefix("es");
        }
    }
    
    /**
     Indication whether this is french locale?
     */
    public var isFrench : Bool{
        get{
            return self.identifier.hasPrefix("fr");
        }
    }
    
    /**
     Indication whether this is russian locale?
     */
    public var isRussian : Bool{
        get{
            return self.identifier.hasPrefix("ru");
        }
    }
}
