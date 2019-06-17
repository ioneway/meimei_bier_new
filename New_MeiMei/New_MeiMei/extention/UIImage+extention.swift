//
//  UIImage+extention.swift
//  newToken_swift
//
//  Created by 王伟 on 2019/1/2.
//  Copyright © 2019 王伟. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension UIImage {
    /// 通过颜色生成图片
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) {
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        context?.setShouldAntialias(true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        guard let cgImage = image?.cgImage else {
            self.init()
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
    /// 图片圆角
    public func roundImage(byRoundingCorners: UIRectCorner = UIRectCorner.allCorners, cornerRadi: CGFloat) -> UIImage? {
        return roundImage(byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: cornerRadi, height: cornerRadi))
    }
    
    /// 图片圆角
    public func roundImage(byRoundingCorners: UIRectCorner = UIRectCorner.allCorners, cornerRadii: CGSize) -> UIImage? {
        
        let imageRect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        guard context != nil else {
            return nil
        }
        context?.setShouldAntialias(true)
        let bezierPath = UIBezierPath(roundedRect: imageRect,
                                      byRoundingCorners: byRoundingCorners,
                                      cornerRadii: cornerRadii)
        bezierPath.close()
        bezierPath.addClip()
        self.draw(in: imageRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 图片缩放
    public func scaleTo(size targetSize: CGSize) -> UIImage? {
        let srcSize = self.size
        if __CGSizeEqualToSize(srcSize, targetSize) {
            return self
        }
        
        let scaleRatio = targetSize.width / srcSize.width
        var dstSize = CGSize(width: targetSize.width, height: targetSize.height)
        let orientation = self.imageOrientation
        var transform = CGAffineTransform.identity
        switch orientation {
        case .up:
            transform = CGAffineTransform.identity
        case .upMirrored:
            transform = CGAffineTransform(translationX: srcSize.width, y: 0.0)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
        case .down:
            transform = CGAffineTransform(translationX: srcSize.width, y: srcSize.height)
            transform = transform.scaledBy(x: 1.0, y: CGFloat(Double.pi))
        case .downMirrored:
            transform = CGAffineTransform(translationX: 0.0, y: srcSize.height)
            transform = transform.scaledBy(x: 1.0, y: -1.0)
        case .leftMirrored:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(translationX: srcSize.height, y: srcSize.width)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
            transform = transform.rotated(by: CGFloat(3.0) * CGFloat(Double.pi))
        case .left:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(translationX: 0.0, y: srcSize.width)
            transform = transform.rotated(by: CGFloat(3.0) * CGFloat(Double.pi))
        case .rightMirrored:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            transform = transform.rotated(by:  CGFloat(Double.pi))
        default:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            transform = CGAffineTransform(translationX: srcSize.height, y: 0.0)
            transform = transform.rotated(by:  CGFloat(Double.pi))
        }
        
        UIGraphicsBeginImageContextWithOptions(dstSize, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        guard context != nil else {
            return nil
        }
        context?.setShouldAntialias(true)
        if orientation == UIImage.Orientation.right || orientation == UIImage.Orientation.left {
            context?.scaleBy(x: -scaleRatio, y: scaleRatio)
            context?.translateBy(x: -srcSize.height, y: 0)
        }
        else {
            context?.scaleBy(x: scaleRatio, y: -scaleRatio)
            context?.translateBy(x: 0, y: -srcSize.height)
        }
        context?.concatenate(transform)
        guard let cgImage = self.cgImage else {
            return nil
        }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: srcSize.width, height: srcSize.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
     /// 图片缩放
    public func scaleTo(fitSize targetSize: CGSize, scaleIfSmaller: Bool = false) -> UIImage? {
        let srcSize = self.size
        if __CGSizeEqualToSize(srcSize, targetSize) {
            return self
        }
        
        let orientation = self.imageOrientation
        var dstSize = targetSize
        switch orientation {
        case .left, .right, .leftMirrored, .rightMirrored:
            dstSize = CGSize(width: dstSize.height, height: dstSize.width)
        default:
            break
        }
        if !scaleIfSmaller && (srcSize.width < dstSize.width) && (srcSize.height < dstSize.height) {
            dstSize = srcSize
        }
        else {
            let wRatio = dstSize.width / srcSize.width
            let hRatio = dstSize.height / srcSize.height
            dstSize = wRatio < hRatio ?
                CGSize(width: dstSize.width, height: srcSize.height * wRatio) :
                CGSize(width: srcSize.width * wRatio, height: dstSize.height)
        }
        return self.scaleTo(size: dstSize)
    }
}



