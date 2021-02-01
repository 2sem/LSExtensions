//
//  CIFilter+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2021/02/01.
//  Copyright © 2021 leesam. All rights reserved.
//

import Foundation
import CoreImage
import UIKit

extension CIFilter{
    /// create filter to overlay image given alphaed color
    /// - Parameters:
    ///   - image: image to overlay with color
    ///   - color: color to overlay image
    ///   - alpha: alpha for color
    /// - Returns: filter to overlay image given alphaed color
    static func monochrome(_ image : UIImage, color: UIColor, alpha: CGFloat = 1.0) -> CIFilter?{
        guard let cgImage = image.cgImage, let filter = self.monochrome(cgImage, color: color, alpha: alpha) else{
            return nil;
        }
        
        return filter;
    }
    
    /// create filter to overlay image given alphaed color
    /// - Parameters:
    ///   - image: image to overlay with color
    ///   - color: color to overlay image
    ///   - alpha: alpha for color
    /// - Returns: filter to overlay image given alphaed color
    static func monochrome(_ image : CGImage, color: UIColor, alpha: CGFloat = 1.0) -> CIFilter?{
        let ciImage = CIImage.init(cgImage: image);
        let ciColor = CIColor.init(color: color);
        guard let filter = self.monochrome(ciImage, color: ciColor, alpha: alpha) else{
            return nil;
        }
        
        return filter;
    }
    
    /// create filter to overlay image given alphaed color
    /// - Parameters:
    ///   - image: image to overlay with color
    ///   - color: color to overlay image
    ///   - alpha: alpha for color
    /// - Returns: filter to overlay image given alphaed color
    static func monochrome(_ image : CGImage, color: CIColor, alpha: CGFloat = 1.0) -> CIFilter?{
        let ciImage = CIImage.init(cgImage: image);
        guard let filter = self.monochrome(ciImage, color: color, alpha: alpha)  else{
            return nil;
        }
        
        return filter;
    }
    
    /// create filter to overlay image given alphaed color
    /// - Parameters:
    ///   - image: image to overlay with color
    ///   - color: color to overlay image
    ///   - alpha: alpha for color
    /// - Returns: filter to overlay image given alphaed color
    static func monochrome(_ image : CIImage, color: CIColor, alpha: CGFloat = 1.0) -> CIFilter?{
        guard let filter = CIFilter.init(name: "CIColorMonochrome", parameters: [kCIInputImageKey : image, "inputIntensity" : alpha, "inputColor" : color]) else{
            return nil;
        }
        
        return filter;
    }
}
