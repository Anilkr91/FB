//
//  BaseViewController.swift
//  StayAPT
//
//  Created by admin on 24/08/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
     var hud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //view.backgroundColor = UIColor(red: 53/255, green: 53/255, blue: 53/255, alpha: 1)
    }
    
    func showHUD() {
       
        if let window = UIApplication.shared.delegate?.window {
            hud = MBProgressHUD.showAdded(to: window!, animated: true)
            hud.bezelView.color = UIColor.red
            hud.label.text = "Please wait..."
            hud.label.font = UIFont(name: "Open Sans", size: 12)
        
            hud.bezelView.backgroundColor = UIColor.clear
            hud.bezelView.style = .blur
        }
    }
    
     func hideHUD() {
        if hud != nil {
            hud.hide(animated: true)
        }
    }
}

class BaseTableViewController: UITableViewController {
    
     var hud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         //view.backgroundColor = UIColor(red: 53/255, green: 53/255, blue: 53/255, alpha: 1)
    }
    
    func showHUD() {
        
        if let window = UIApplication.shared.delegate?.window {
            hud = MBProgressHUD.showAdded(to: window!, animated: true)
            hud.bezelView.color = UIColor.red
            hud.label.text = "Please wait..."
            hud.label.font = UIFont(name: "Open Sans", size: 12)
            
            hud.bezelView.backgroundColor = UIColor.clear
            hud.bezelView.style = .blur
        }
    }
    
    func hideHUD() {
        if hud != nil {
            hud.hide(animated: true)
        }
    }
    
}

class BaseCollectionViewController: UICollectionViewController {
    
    var hud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //collectionView?.backgroundColor = UIColor(red: 53/255, green: 53/255, blue: 53/255, alpha: 1)
    }
    
    func showHUD() {
        
        if let window = UIApplication.shared.delegate?.window {
            hud = MBProgressHUD.showAdded(to: window!, animated: true)
            hud.bezelView.color = UIColor.red
            hud.label.text = "Please wait..."
            hud.label.font = UIFont(name: "Open Sans", size: 12)
            
            hud.bezelView.backgroundColor = UIColor.clear
            hud.bezelView.style = .blur
        }
    }
    
    func hideHUD() {
        if hud != nil {
            hud.hide(animated: true)
        }
    }
}

//extension UIViewController {
//    
//    func showAlert(_ title: String, msg: String) {
//        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
//    }
//}
