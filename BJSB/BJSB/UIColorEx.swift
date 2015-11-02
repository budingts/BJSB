//
//  UIColorEx.swift
//  MobileLesson
//
//  Created by juanq on 15/10/23.
//  Copyright © 2015年 Easytech. All rights reserved.
//

import Foundation
import UIKit

//MARK:----颜色部分
extension UIColor{
    class func colorFromRGB (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)->UIColor
    {
        return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a);
    }
    class func colorFromHEX (hexValue: UInt)->UIColor
    {
        return UIColor ( red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0));
    }
    
    
    class func colorWithHex(hex: String, alpha: CGFloat) -> UIColor {
        var rgb: CUnsignedInt = 0;
        let scanner = NSScanner(string: hex)
        
        if hex.hasPrefix("#") {
            // skip '#' character
            scanner.scanLocation = 1
        }
        scanner.scanHexInt(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
   
}