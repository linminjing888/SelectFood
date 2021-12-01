//
//  UIImageExtension.swift
//  SelectFood
//
//  Created by minjing.lin on 2021/11/17.
//

import UIKit

extension UIImage {
    
    ///用颜色创建一张图片
   static func creatColorImage(_ color:UIColor,_ ARect:CGRect = CGRect.init(x: 0, y: 0, width: 1, height: 1)) -> UIImage {
        let rect = ARect
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
