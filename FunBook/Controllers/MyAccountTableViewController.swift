//
//  MyAccountTableViewController.swift
//  FunBook
//
//  Created by admin on 05/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import Kingfisher

class MyAccountTableViewController: BaseTableViewController {
    
    let user = LoginUtils.getCurrentMemberUserLogin()!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabelTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(user)
        setupViewWithUserData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViewWithUserData() {
        nameLabelTextField.text = user.name
        emailTextField.text = user.email
        
        let imageUrl:String = user.picture.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: imageUrl)
        let placeholderImage = UIImage(named: "loader")
        print(url)
        userImageView.kf.setImage(with: url, placeholder: placeholderImage)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        
        if indexPath.section == 1 {
            performSegue(withIdentifier: "EditAcountSegue", sender: self)
            
        } else if indexPath.section == 3 {
            performSegue(withIdentifier: "AddressBookSegue", sender: self)
            
        } else if indexPath.section == 6 {
            performSegue(withIdentifier: "showChangePasswordSegue", sender: self)
            
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let param = ["deviceType": "iOS" , "deviceID": "12345678"]
        LogoutPostService.executeRequest(param, vc: self) { (response) in
            print(response)
            LoginUtils.setCurrentMemberUserLogin(nil)
            let application = UIApplication.shared.delegate as! AppDelegate
            application.setHomeGuest()
        }
    }
}
