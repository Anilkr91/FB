//
//  EditProfileTableViewController.swift
//  FunBook
//
//  Created by admin on 05/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

class EditProfileTableViewController: BaseTableViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // User
    let user = LoginUtils.getCurrentMemberUserLogin()!
    let tapGesture =  UITapGestureRecognizer()
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(user)
        
        userImageView.isUserInteractionEnabled  = true
        tapGesture.addTarget(self, action: #selector(EditProfileTableViewController.uploadImage))
        userImageView.addGestureRecognizer(tapGesture)
        
        setupViewWithUserData()
        // Do any additional setup after loading the view.
    }
    
    func uploadImage() {
        handleImageTapGestureRecognizer()
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
    
    func setupViewWithUserData() {
        nameTextField.text = user.name
        emailTextField.text = user.email
        
        let imageUrl:String = user.picture.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: imageUrl)
        let placeholderImage = UIImage(named: "placeholder-profile")
        userImageView.kf.setImage(with: url, placeholder: placeholderImage)
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        
        let name = nameTextField.text!
        
        if name.removeAllSpaces().isEmpty {
            showAlert("Error", message: "User id cannot be empty")
            
        } else {
            print("validation passed hit api")
            let param = ["name": name]
            
            editprofile(param)
        }
    }
    
    func editprofile(_ param: [String: Any]) {
        
        EditProfilePostService.executeRequest(param, vc: self) { (response) in
            
            if response.status == true && response.statusCode == 200 {
                LoginUtils.setCurrentMemberUserLogin(response.user)
                self.showSucessAlert("Success", message: response.success)
            }
        }
    }
    
    func showSucessAlert(_ title: String, message: String) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertView.addAction(OKAction)
        self.present(alertView, animated: true, completion: nil)
    }
}

extension EditProfileTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleImageTapGestureRecognizer() {
        let imagePickerMenu = UIAlertController(title: "Choose image to upload", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.imagePickerController.sourceType = .camera
            self.imagePickerController.cameraDevice = .front
            self.presentImagePickerController()
        })
        
        let galleryAction = UIAlertAction(title: "Choose from Library", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.imagePickerController.sourceType = .photoLibrary
            self.presentImagePickerController()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        imagePickerMenu.addAction(cameraAction)
        imagePickerMenu.addAction(galleryAction)
        imagePickerMenu.addAction(cancelAction)
        
        imagePickerMenu.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        self.present(imagePickerMenu, animated: true, completion: nil)
    }
    
    func presentImagePickerController() {
        self.imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imagePickerController.dismiss(animated: true, completion: nil)
        
        if let imageData = image?.jpeg(.low)  {
            
            ////            print(imageData.count)
            //
            ////            print("size of image in KB: %f ", Double(imageData.count) / 1024.0 )
            //
            //
            //            let countBytes = ByteCountFormatter()
            //            countBytes.allowedUnits = [.useMB]
            //            countBytes.countStyle = .file
            //            let fileSize = countBytes.string(fromByteCount: Int64(imageData.count))
            //
            //            print("File size: \(fileSize)")
            //
            
            UploadImagePostService.executeRequest(imageData, image: "", completionHandler: { (response) in
                
                LoginUtils.setCurrentMemberUserLogin(response.user)
                self.userImageView.image = image
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
