//
//  UIKit+Extension.swift
//  Alamofire
//
//  Created by Jesse on 2019/3/10.
//

import Foundation

extension UIColor {

    public convenience init(hex: String) {

        let scanner = Scanner(string: hex)
        scanner.scanLocation = 1

        var rgbValue: UInt32 = 0

        scanner.scanHexInt32(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: 1)
    }

    /// convert to an image
    var image: UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context!.setFillColor(self.cgColor)
        context!.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
