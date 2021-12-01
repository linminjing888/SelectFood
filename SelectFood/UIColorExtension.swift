//
//  UIColorExtension.swift
//  ZQCloud
//
//  Created by minjing.lin on 2021/10/20.
//  Copyright © 2021 中企悦动圈 (苏州)网络科技有限公司. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: 根据 RGBA 设置颜色颜色
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    // MARK: 十六进制字符串设置颜色
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        
        let color = Self.hexStringToColorRGB(hexString: hexString)
        guard let r = color.r, let g = color.g, let b = color.b else {
            #if DEBUG
            assert(false, "不是十六进制值")
            #endif
            return nil
        }
        self.init(r: r, g: g, b: b, alpha: alpha)
    }
    
    // MARK: 根据 十六进制颜色获取 RGB
    // 根据 十六进制字符串 颜色获取 RGB，如：#3CB371 或者 ##3CB371 -> 60,179,113
    static func hexStringToColorRGB(hexString: String) -> (r: CGFloat?, g: CGFloat?, b: CGFloat?) {
        // 1、判断字符串的长度是否符合
        guard hexString.count >= 6 else {
            return (nil, nil, nil)
            
        }
        // 2、将字符串转成大写
        var tempHex = hexString.uppercased()
        // 3、判断开头： 0x/#/##
        if tempHex.hasPrefix("0X") || tempHex.hasPrefix("##") {
            tempHex = String(tempHex[tempHex.index(tempHex.startIndex, offsetBy: 2)..<tempHex.endIndex])
        }
        if tempHex.hasPrefix("#") {
            tempHex = String(tempHex[tempHex.index(tempHex.startIndex, offsetBy: 1)..<tempHex.endIndex])
        }
        // 4、分别取出 RGB
        // FF --> 255
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        // 5、将十六进制转成 255 的数字
        var r: UInt32 = 0, g: UInt32 = 0, b: UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        return (r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
   }
    
    

    static let SMainThemeColor = UIColor(hexString:"0xFF7600")

    static let swiftViewBgColor = UIColor(hexString:"0xF5F5F5")
    
    static let swiftMidBlackColor = UIColor(hexString:"0x333333")
    
    static let swiftLightGrayCOLOR = UIColor(hexString:"0x999999")
    
}
