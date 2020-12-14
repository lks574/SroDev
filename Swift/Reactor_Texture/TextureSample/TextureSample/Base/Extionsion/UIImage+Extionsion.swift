//
//  UIImage+Extionsion.swift
//  TextureSample
//
//  Created by KyungSeok Lee on 2020/12/14.
//

import AsyncDisplayKit

extension UIImage {
    
    class func backgroundImage(color: UIColor, size: CGSize = .init(width: 1, height: 1)) -> UIImage? {
        var rect: CGRect = .zero
        rect.size = size
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

