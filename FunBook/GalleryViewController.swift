//
//  ViewController.swift
//  FunBook
//
//  Created by admin on 27/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
import OpalImagePicker
import Photos
import Alamofire

class GalleryViewController: BaseViewController {
    
    var array: [PrepareAlbumModel] = []
    var albumName: String = ""
    var album: AlbumResponseModel?
    var albumModel: [AlbumResponseModel] = []
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // clear album array
        array.removeAll()
        
        //fetch all albums
        getAllAlbums()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openGallery(_ sender: UIButton) {
        performSegue(withIdentifier: "showAlbumSegue", sender: self)
        
//        let alertController = UIAlertController(title: "Add Album Title", message: "", preferredStyle: .alert)
//        alertController.addTextField { (textField : UITextField) -> Void in
//
//            textField.placeholder = "Enter Album Name.."
            //            textField.isSecureTextEntry = true
            
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
//            }
//            let okAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            
//                if let field = alertController.textFields![0] as UITextField? {
//
//                    if field.text!.isEmpty {
//                        print("empty")
//
//                    } else {
//                        self.albumName = field.text!
//
//                        let imagePicker = OpalImagePickerController()
//                        imagePicker.maximumSelectionsAllowed = 3
//
//                        let configuration = OpalImagePickerConfiguration()
//                        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You cannot select that many images!", comment: "")
//                        imagePicker.configuration = configuration
//
//                        imagePicker.imagePickerDelegate = self
//                        self.present(imagePicker, animated: true, completion: nil)
//
//                    }
//                }
//            }
            
//            alertController.addAction(cancelAction)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//
//
//        alertController.addTextField { (textField : UITextField) -> Void in
//
//            textField.placeholder = "Enter Album Description.."
//            //            textField.isSecureTextEntry = true
//
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
//            }
//            let okAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
//
//                if let field = alertController.textFields![0] as UITextField? {
//
//                    if field.text!.isEmpty {
//                        print("empty")
//
//                    } else {
//                        self.albumName = field.text!
//
//                        let imagePicker = OpalImagePickerController()
//                        imagePicker.maximumSelectionsAllowed = 3
//
//                        let configuration = OpalImagePickerConfiguration()
//                        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You cannot select that many images!", comment: "")
//                        imagePicker.configuration = configuration
//
//                        imagePicker.imagePickerDelegate = self
//                        self.present(imagePicker, animated: true, completion: nil)
//
//                    }
//                }
//            }
//
//            alertController.addAction(cancelAction)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//
//
//
//
    }
}


extension GalleryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return albumModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlbumTableViewCell
        
        cell.info = albumModel[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        album = albumModel[indexPath.section]
        self.performSegue(withIdentifier: "showAlbumDetail", sender: self)
    }
}

//extension GalleryViewController: GalleryControllerDelegate {
//
//    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
//        array = images.flatMap { $0.uiImage(ofSize: UIScreen.main.bounds.size) }
//
//    }
//
//    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
//
//    }
//
//    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
//        self.performSegue(withIdentifier: "showSelectedImagesSegue", sender: self)
//
//    }
//
//    func galleryControllerDidCancel(_ controller: GalleryController) {
//        controller.dismiss(animated: true, completion: nil)
//        gallery = nil
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "showSelectedImagesSegue" {
//
//            let dvc = segue.destination as! SelectedImagesCollectionViewController
//           dvc.array = array
//            print(dvc)
//
//        }
//    }
//}

extension GalleryViewController: OpalImagePickerControllerDelegate {
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        
        for image in images.enumerated() {
            
           array.append(PrepareAlbumModel(image: image.element, caption: "", date: "", index: image.offset))
        }
        
        picker.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "showSelectedImagesSegue", sender: self)
        
//        let user = LoginUtils.getCurrentMemberUserLogin()!
//        
//        let captions = ["Caption1", "Caption2", "Caption3", "Caption4"]
//        let URL = Constants.BASE_URL
//        
//        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY,
//                                   "userToken": user.userToken,
//                                   "userID": user.userID ]
//        
//        
//        let r =  Alamofire.upload(multipartFormData: { multipartFormData in
//            
//            for image in images {
//                
//                if let imageData = image.jpeg(.highest)  {
//                    multipartFormData.append(imageData, withName: "gallery[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//                }
//            }
//            
//            for caption in captions {
//                multipartFormData.append(caption.data(using: String.Encoding.utf8)!, withName: "caption[]")
//            }
//            
//            multipartFormData.append(self.albumName.data(using: String.Encoding.utf8)!, withName: "albumName")
//            multipartFormData.append("4".data(using: .utf8)!, withName: "addressID")
//            
//        },
//                                  
//                                  usingThreshold:UInt64.init(),
//                                  to: URL + "profile/create_album",
//                                  method:.post,
//                                  headers: header,
//                                  
//                                  encodingCompletion: { encodingResult in
//                                    debugPrint(request)
//                                    switch encodingResult {
//                                    case .success(let upload, _, _):
//                                        debugPrint(upload)
//                                        upload.responseJSON { response in
//                                            
//                                            print(response)
//                                            
//                                            picker.dismiss(animated: true, completion: nil)
//                                            
//                                        }
//                                    case .failure(let error):
//                                        print(error)
//                                    }
//                                    
//        })
//        debugPrint(r)
        
    }
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
        
        print(assets)
        
    }
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showSelectedImagesSegue" {
            
            let dvc = segue.destination as! SelectedImagesCollectionViewController
            dvc.array = array
            print(dvc)
            
        } else if segue.identifier == "showAlbumDetail" {
            
            let dvc = segue.destination as! AlbumDetailTableViewController
            dvc.navigationItem.title = album?.albumName
            dvc.albumId = album!.albumID
        }
    }
}

extension GalleryViewController {
    
    func getAllAlbums() {
        
        AlbumListingGetService.executeRequest(vc: self) { (response) in
            print(response)
            self.albumModel = response
            self.tableview.reloadData()
            
        }
    }
}
