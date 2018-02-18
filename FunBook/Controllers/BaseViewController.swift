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
        setupNavigationAppearance()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupNavigationAppearance() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "33AEF5")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    func showHUD(text: String) {
        
        if let window = UIApplication.shared.delegate?.window {
            hud = MBProgressHUD.showAdded(to: window!, animated: true)
            hud.bezelView.color = UIColor.red
            hud.label.text = text
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
    
    func showAlert(_ title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil )
        
        alertView.addAction(OK)
        self.present(alertView, animated: true, completion: nil)
    }
}

class BaseTableViewController: UITableViewController {
    
    var hud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationAppearance()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupNavigationAppearance() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "33AEF5")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
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
    
    func showAlert(_ title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil )
        
        alertView.addAction(OK)
        self.present(alertView, animated: true, completion: nil)
    }
}

class BaseCollectionViewController: UICollectionViewController {
    
    var hud: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationAppearance()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupNavigationAppearance() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "33AEF5")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
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
    
    func showAlert(_ title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil )
        
        alertView.addAction(OK)
        self.present(alertView, animated: true, completion: nil)
    }
}
