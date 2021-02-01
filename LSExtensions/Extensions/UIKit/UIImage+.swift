//
//  UIImage+.swift
//  LSExtensions
//
//  Created by 영준 이 on 2021/02/01.
//  Copyright © 2021 leesam. All rights reserved.
//

import UIKit

extension UIImage{
    /**
        Returns new image redrawed with given size and background color
        - parameter size: size of new image
        - parameter backgroundColor: background color of new image
        - returns: new image redrawed with given size and background color
    */
    public func image(withSize size : CGSize, backgroundColor : UIColor? = nil) -> UIImage{
        var value = self;
        
        UIGraphicsBeginImageContext(size);
        let ctx = UIGraphicsGetCurrentContext();
        
        let rect = CGRect(origin: CGPoint.zero, size: size);
        //fill with background color if it was specified
        if let color = backgroundColor{
            ctx!.setFillColor(color.cgColor);
            ctx!.fill(rect);
        }
        
        //redraw image with given size
        self.draw(in: rect);
        
        value = UIGraphicsGetImageFromCurrentImageContext()!;
        
        UIGraphicsEndImageContext();
        
        return value;
    }
    
    /**
         Store PNG Image converted from this image to given url and returns whether success or failed
         - Parameter url: URL where to store PNG file
     */
    open func save(asPngUrl url: URL) -> Bool{
        var value = false;
        let data = self.pngData();
        value = (try? data?.write(to: URL(fileURLWithPath: url.path), options: [.atomic])) != nil;
        
        return value;
    }
    
    /**
         Save this image into photo album in device
         - Parameters:
             - target: Target to notify did finish saving image file to album
             - selector: Method to call when saving image to album has been completed
             - context: Context to use image processing?
     */
    open func saveToAlbum(_ target: Any? = nil, selector: Selector? = nil, context: UnsafeMutableRawPointer? = nil){
        UIImageWriteToSavedPhotosAlbum(self, target ?? self, selector ?? #selector(self.image(_:didFinishSavingWithError:contextInfo:)), context);
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            debugPrint("can not save image to album. error[\(error)]");
        }
    }
    
    /// create new image covered with given alphaed color
    /// - Parameters:
    ///   - color: color to cover image
    ///   - alpha: alpha for the coverring color
    /// - Returns: return new image covered with given alphaed color
    open func coloredByMonochrome(_ color: UIColor, alpha: CGFloat = 0.5) -> UIImage {
        let context = CIContext();
        
        guard let filteredImage = CIFilter.monochrome(self, color: color, alpha: alpha)?.outputImage else{
            return self;
        }
        
        guard let cgImage : CGImage = context.createCGImage(filteredImage, from: filteredImage.extent) else{
            return self;
        }
        
        let coloredImg : UIImage = UIImage.init(cgImage: cgImage);
        
        return coloredImg
    }
    
    /// creates new image filled gradient generated given color, size, and range
    /// https://www.appcoda.com/cagradientlayer
    /// - Parameters:
    ///   - colors: color list for gradient
    ///   - size: size for gradient image
    ///   - start: position to start drawing gradient
    ///   - end: position to end drawing gradient
    /// - Returns:new image filled gradient generated given color, size, and range
    public static func gradient(colors: [UIColor], size: CGSize, start: CGPoint = .init(x: 0.0, y: 0.5), end: CGPoint = .init(x: 1.0, y: 0.5)) -> UIImage?{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect.init(origin: .zero, size: size);
        gradientLayer.startPoint = start;
        gradientLayer.endPoint = end;
        gradientLayer.colors = colors.map{ $0.cgColor }
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let value = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return value
    }
    
    /// Returns filled circle image - use to create small thumb for player's track bar
    /// - Parameters:
    ///   - size: Circle size to create
    ///   - frameSize: Image size contain circle
    ///   - color: Color to fill inside of the circle
    public static func circle(size: CGFloat, frameSize: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: frameSize, height: frameSize), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        let rect = CGRect(x: frameSize / 2 - size / 2, y: frameSize / 2 - size / 2, width: size, height: size)
        ctx.setFillColor(color.cgColor)
        ctx.fillEllipse(in: rect)
        
        ctx.restoreGState()
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
}
