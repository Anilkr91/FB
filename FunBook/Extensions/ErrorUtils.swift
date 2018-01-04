//
//  ErrorUtils.swift
//  StayAPT
//
//  Created by admin on 12/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//


import UIKit

class ErrorUtils {
    
    class func showError(title: String, message: String, vc: UIViewController) {
        
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil )
        
        alertView.addAction(OK)
        vc.present(alertView, animated: true, completion: nil)
    }
}
