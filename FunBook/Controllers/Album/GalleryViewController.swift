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
import RealmSwift

class GalleryViewController: BaseViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var albumName: String = ""
    var album: AlbumModel?
    var albums: [AlbumModel] = []
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAlbumFromRealmDB()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openGallery(_ sender: UIButton) {
        performSegue(withIdentifier: "showAlbumSegue", sender: self)
        
    }
}

extension GalleryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if albums[indexPath.section].status == AlbumStatus.Pending.rawValue {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "paymentPendingCell", for: indexPath) as! RealmAlbumTableViewCell
            
            cell.info = albums[indexPath.section]
            return cell
            
        } else if  albums[indexPath.section].status == AlbumStatus.PaymentComplete.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCompleteCell", for: indexPath) as! RealmPaymentCompleteTableViewCell
            
            cell.info = albums[indexPath.section]
            cell.uploadButton.tag = indexPath.section
            cell.uploadButton.addTarget(self, action: #selector(uploadAlbum), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
        
        
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
        album = albums[indexPath.section]
        
        if albums[indexPath.section].status == AlbumStatus.Pending.rawValue {
            self.performSegue(withIdentifier: "showSelectedImagesSegue", sender: self)
            
        } else if albums[indexPath.section].status == AlbumStatus.PaymentComplete.rawValue {
            return
            
        } else {
            return
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if albums[indexPath.section].status == AlbumStatus.PaymentComplete.rawValue {
            return false
            
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            deleteObjectFromRealmDB(album: albums[indexPath.section])
        }
    }
}

extension GalleryViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSelectedImagesSegue" {
            let dvc = segue.destination as! SelectedImagesCollectionViewController
            dvc.album = album
            dvc.galleryVC = self
        }
    }
    
    func getAlbumFromRealmDB() {
        
        do {
            albums = realm.objects(AlbumModel.self).toArray(ofType: AlbumModel.self)
            self.tableview.reloadData()
        }
    }
    
    func deleteObjectFromRealmDB(album: AlbumModel) {
        try! self.realm.write({
            realm.delete(album)
            
        })
        getAlbumFromRealmDB()
    }
    
    func uploadAlbum(_ sender: UIButton) {
        ProgressBarView.showHUD(textString: "Upload in Progress...")
        let album = albums[sender.tag]
        
        var param =  AlbumTransformerModel(coverImage: album.coverImage, name: album.name, description: album.definition, date: album.date, addressId: album.addressId, images: [], albumTypeId: album.albumTypeId, albumQuantity: album.albumQuantity, albumPrice: album.albumPrice, albumTotalPrice: album.albumTotalPrice, paypalResponseId: album.paypalResponseId, shippingId: album.shipping!.id)
        
        for image in album.images.enumerated() {
            let img = UIImage(data: image.element.image!)
            
            let obj = PrepareAlbumTransformerModel(image: img!, caption: image.element.caption, date: image.element.date, index: image.element.index)
            param.images.append(obj)
        }
        self.uploadAlbumToServer(param: param, album: album)
    }
    
    func uploadAlbumToServer(param: AlbumTransformerModel, album: AlbumModel) {
        let user = LoginUtils.getCurrentMemberUserLogin()!
        let URL = Constants.BASE_URL
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY,
                                   "userToken": user.userToken,
                                   "userID": user.userID ]
        
        
        let r =  Alamofire.upload(multipartFormData: { multipartFormData in
            for img in param.images.enumerated() {
                
                
                if let imageData = img.element.image.jpeg(.highest) {
                    multipartFormData.append(imageData, withName: "gallery[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    multipartFormData.append(img.element.caption.data(using: String.Encoding.utf8)!, withName: "caption[]")
                    multipartFormData.append(img.element.date.data(using: String.Encoding.utf8)!, withName: "imageDate[]")
                }
            }
            
            multipartFormData.append(param.name.data(using: String.Encoding.utf8)!, withName: "albumName")
            multipartFormData.append(param.description.data(using: String.Encoding.utf8)!, withName: "albumDescription")
            multipartFormData.append(param.date.data(using: String.Encoding.utf8)!, withName: "albumDate")
            multipartFormData.append(param.addressId.data(using: .utf8)!, withName: "addressID")
            multipartFormData.append("\(param.albumQuantity)".data(using: .utf8)!, withName: "quantity")
            multipartFormData.append(param.albumPrice.data(using: .utf8)!, withName: "price")
            multipartFormData.append(param.albumTypeId.data(using: .utf8)!, withName: "albumType")
            multipartFormData.append(param.shippingId.data(using: .utf8)!, withName: "shippingCharges")
            multipartFormData.append(param.paypalResponseId.data(using: .utf8)!, withName: "paymentId")
            multipartFormData.append(param.albumTotalPrice.data(using: .utf8)!, withName: "totalPrice")
            multipartFormData.append("\(param.coverImage)".data(using: String.Encoding.utf8)!, withName: "coverImage")
            
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
                                            ProgressBarView.hideHUD()
                                            self.deleteObjectFromRealmDB(album: album)
                                            
                                        }
                                    case .failure(let error):
                                        print(error)
                                    }
                                    
        })
        debugPrint(r)
    }
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for result in self {
            if let result = result as? T {
                array.append(result)
            }
        }
        return array
    }
}
