//
//  ViewController.swift
//  FunBook
//
//  Created by admin on 27/12/17.
//  Copyright © 2017 Techximum. All rights reserved.
//

import UIKit
//import Gallery
//import Lightbox
//import AVFoundation
//import AVKit

import OpalImagePicker
import Photos
import Alamofire


class GalleryViewController: UIViewController {
    
    //    var gallery: GalleryController!
    var array: [UIImage] = []
    //    var albumModel: [PrepareAlbumModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openGallery(_ sender: UIButton) {
        
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func login() {
        
        let param = ["email": "anil.techximum@gmail.com","password": "123456789","deviceType": "2","deviceID" : "234567890"]
        LoginPostService.executeRequest(param, vc: self) { (response) in
            
            print(response)
        }
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
        
        array = images
        
        let user = LoginUtils.getCurrentMemberUserLogin()!
        
        let captions = ["Caption1", "Caption2", "Caption3", "Caption4"]
        let URL = Constants.BASE_URL
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY,
                                   "userToken": user.userToken,
                                   "userID": user.userID ]

        
        let r =  Alamofire.upload(multipartFormData: { multipartFormData in
            
            for image in images {
            
                if let imageData = image.jpeg(.highest)  {
                    multipartFormData.append(imageData, withName: "gallery[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
            
            for caption in captions {
                multipartFormData.append(caption.data(using: String.Encoding.utf8)!, withName: "caption[]")
            }
            
            multipartFormData.append("Album1".data(using: String.Encoding.utf8)!, withName: "albumName")
             multipartFormData.append("1".data(using: String.Encoding.utf8)!, withName: "address")
            
        },
                                    
                                    usingThreshold:UInt64.init(),
                                    to: URL + "profile/create_album",
                                    method:.post,
                                    headers: header,
                                    
                                    encodingCompletion: { encodingResult in
                                        debugPrint(request)
                                        switch encodingResult {
                                        case .success(let upload, _, _):
                                            debugPrint(upload)
                                            upload.responseJSON { response in
                                                
                                                print(response)
                                                
                                            }
                                        case .failure(let error):
                                            print(error)
                                        }
                                        
        })
        debugPrint(r)
    
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
            
        }
    }
}
