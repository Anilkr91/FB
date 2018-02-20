//
//  ProgressBarView.swift
//  MWM
//
//  Created by admin on 20/10/17.
//  Copyright © 2017 Techximum. All rights reserved.
//


import MBProgressHUD

class ProgressBarView {
    
    static var hud: MBProgressHUD!
    
    class func showHUD(textString: String) {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        if let window = UIApplication.shared.delegate?.window {
            hud = MBProgressHUD.showAdded(to: window!, animated: true)
            hud.bezelView.color = UIColor.red
            hud.label.text = textString
//            hud.label.font = UIFont(name: "Open Sans", size: 12)
            
            hud.bezelView.backgroundColor = UIColor.clear
            hud.bezelView.style = .blur
        }
    }
    
    class func hideHUD() {
        if hud != nil {
            hud.hide(animated: true)
        }
    }
}

