//
//  ViewController.swift
//  FunBook
//
//  Created by admin on 27/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        login()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func login() {
        
        let param = ["email": "anil.techximum@gmail.com","password": "123456789","deviceType": "2","deviceID" : "234567890"]
        LoginPostService.executeRequest(param, vc: self) { (response) in
        
            print(response)
        }
    }
}

