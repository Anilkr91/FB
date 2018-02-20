//
//  Extension+Helpers.swift
//  StayAPT
//
//  Created by admin on 08/09/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

extension String {
    func removeAllSpaces () -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern:"^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
}


extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}


extension UINavigationItem {
    //Make the title 2 lines with a title and a subtitle
    func addTitleAndSubtitleToNavigationBar (title: String, subtitle: String) {
        let label = UILabel(frame: CGRect(x: 8, y: 0, width: 40, height: 40))
        
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.numberOfLines = 2
        label.text = "\(title)\n\(subtitle)"
        label.textColor = UIColor.white
        label.sizeToFit()
        label.textAlignment = NSTextAlignment.center
        self.titleView = label
    }
}

//import UIKit
//
//extension String {
//    
//    //Validate Email
//    var isEmail: Bool {
//        do {
//            let regex = try NSRegularExpression(pattern:"^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$", options: .CaseInsensitive)
//            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
//        } catch {
//            return false
//        }
//    }
//    
//    //validate Password
//    var isPassword: Bool {
//        do {
//            let regex = try NSRegularExpression(pattern:"^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[!@#%&*]).{8,}$", options: .CaseInsensitive)
//            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
//        } catch {
//            return false
//        }
//    }
//}
