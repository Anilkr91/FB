//
//  SelectedImagesCollectionViewController.swift
//  FunBook
//
//  Created by admin on 09/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import OpalImagePicker

private let reuseIdentifier = "Cell"

class SelectedImagesCollectionViewController: BaseCollectionViewController {
    
    var galleryVC: GalleryViewController?
    var album: AlbumModel?
    var albumProperties: PrepareAlbumModel?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let album = album {
            self.navigationItem.title = album.name
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return album!.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SelectedImageCollectionViewCell
        
        cell.info = album?.images[indexPath.item]
        
        if let album = album {
            if album.coverImage == album.images[indexPath.item].index {
                cell.coverLabel.text = "Cover"
                
            } else {
                cell.coverLabel.text = ""
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        albumProperties = album!.images[indexPath.item]
        performSegue(withIdentifier: "showImageSegue", sender: self)
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Select", message: nil, preferredStyle: .actionSheet)
        let addPictures = UIAlertAction(title: "Add images", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openOpalImagePicker()
        })
        
        let next = UIAlertAction(title: "Next", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.performSegue(withIdentifier: "showAlbumTypeSegue", sender: self)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(addPictures)
        actionSheet.addAction(next)
        actionSheet.addAction(cancel)
        
        actionSheet.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func openOpalImagePicker() {
        let imagePicker = OpalImagePickerController()
        imagePicker.maximumSelectionsAllowed = 50
        
        let configuration = OpalImagePickerConfiguration()
        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You cannot select that many images!", comment: "")
        imagePicker.configuration = configuration
        imagePicker.imagePickerDelegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showImageSegue" {
            
            let nvc = segue.destination as? UINavigationController
            let dvc = nvc?.viewControllers[0] as? ImageOperationsTableViewController
            dvc?.delegate = self
            dvc?.coverImageIndex = album?.coverImage
            dvc?.albumProperties = albumProperties
            
        } else if segue.identifier == "showAlbumTypeSegue" {
            
            let dvc = segue.destination as! AlbumTypeTableViewController
            dvc.album = album
        }
    }
    
    @IBAction func uploadAlbumButton(_ sender: Any) {
        if let album = album {
            uploadAlbum(param: album)
        }
    }
    
    func uploadAlbum(param: AlbumModel) {
        print(param)
        let user = LoginUtils.getCurrentMemberUserLogin()!
        let URL = Constants.BASE_URL
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY,
                                   "userToken": user.userToken,
                                   "userID": user.userID ]
        
        let r =  Alamofire.upload(multipartFormData: { multipartFormData in
            
            for img in param.images.enumerated() {
                
                if let imageData = img.element.image {
                    multipartFormData.append(imageData, withName: "gallery[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    multipartFormData.append(img.element.caption.data(using: String.Encoding.utf8)!, withName: "caption[]")
                    multipartFormData.append(img.element.date.data(using: String.Encoding.utf8)!, withName: "imageDate[]")
                }
            }
            
            multipartFormData.append(param.name.data(using: String.Encoding.utf8)!, withName: "albumName")
            multipartFormData.append(param.description.data(using: String.Encoding.utf8)!, withName: "albumDescription")
            multipartFormData.append(param.date.data(using: String.Encoding.utf8)!, withName: "albumDate")
            multipartFormData.append("4".data(using: .utf8)!, withName: "addressID")
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
                                            
                                            self.navigationController?.popToRootViewController(animated: true)
                                        }
                                    case .failure(let error):
                                        print(error)
                                    }
                                    
        })
        debugPrint(r)
    }
}

extension SelectedImagesCollectionViewController: UICollectionViewDelegateFlowLayout {
    fileprivate var sectionInsets: UIEdgeInsets {
        return .init(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    fileprivate var itemsPerRow: CGFloat {
        return 3
    }
    
    fileprivate var interitemSpace: CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionPadding = sectionInsets.left * (itemsPerRow + 1)
        let interitemPadding = max(0.0, itemsPerRow - 1) * interitemSpace
        let availableWidth = collectionView.bounds.width - sectionPadding - interitemPadding
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem+30)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}

extension SelectedImagesCollectionViewController: passAlbumDataDelegte {
    
    func didAddCaptionWithDate(caption: String, date: String, index: Int, isCopyToAll: Bool, coverImageIndex: Int) {
        
        if galleryVC == nil {
            print("album information")
            
            newAlbumWithInformation(caption: caption, date: date, index: index, isCopyToAll: isCopyToAll, coverImageIndex: coverImageIndex)
            
        } else {
            print("gallery vc local db")
            
            localAlbumWithInformation(caption: caption, date: date, index: index, isCopyToAll: isCopyToAll, coverImageIndex: coverImageIndex)
        }
    }
}

extension SelectedImagesCollectionViewController: OpalImagePickerControllerDelegate {
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        
        for image in images.enumerated() {
            
            let imageData = UIImagePNGRepresentation(image.element)
            
            if let album = album {
                realm.beginWrite()
                
                let albumProperties = PrepareAlbumModel()
                albumProperties.caption = ""
                albumProperties.date = ""
                albumProperties.image = imageData
                albumProperties.index  = album.images.count + image.offset
                album.images.append(albumProperties)
                
                try! realm.commitWrite()
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
        collectionView?.reloadData()
    }
    
    func newAlbumWithInformation(caption: String, date: String, index: Int, isCopyToAll: Bool, coverImageIndex: Int) {
        
        if isCopyToAll == true {
            
            for arr in album!.images.enumerated() {
                
                if arr.offset == index {
                    
                    if let album = album {
                        
                        album.coverImage = coverImageIndex
                        album.images.remove(at: arr.offset)
                        let albumProperties = PrepareAlbumModel()
                        albumProperties.image = arr.element.image
                        albumProperties.caption = caption
                        albumProperties.date = date
                        albumProperties.index = arr.offset
                        album.images.insert(albumProperties, at: arr.offset)
                        
                    }
                    
                } else {
                    
                    if let album = album {
                        
                        album.coverImage = coverImageIndex
                        album.images.remove(at: arr.offset)
                        let albumProperties = PrepareAlbumModel()
                        albumProperties.image = arr.element.image
                        albumProperties.caption = caption
                        albumProperties.date = date
                        albumProperties.index = arr.offset
                        album.images.insert(albumProperties, at: arr.offset)
                        
                        
                        
                    }
                }
            }
            collectionView?.reloadData()
            
        } else {
            
            for arr in album!.images.enumerated() {
                if arr.offset == index {
                    
                    if let album = album {
                        
                        album.coverImage = coverImageIndex
                        album.images.remove(at: arr.offset)
                        let albumProperties = PrepareAlbumModel()
                        albumProperties.image = arr.element.image
                        albumProperties.caption = caption
                        albumProperties.date = date
                        albumProperties.index = arr.offset
                        album.images.insert(albumProperties, at: arr.offset)
                        
                    }
                }
            }
            collectionView?.reloadData()
        }
    }
    
    func localAlbumWithInformation(caption: String, date: String, index: Int, isCopyToAll: Bool, coverImageIndex: Int) {
        
        if isCopyToAll == true {
            
            for arr in album!.images.enumerated() {
                
                if arr.offset == index {
                    
                    if let album = album {
                        
                        try! realm.write {
                            album.coverImage = coverImageIndex
                            album.images.remove(at: arr.offset)
                            let albumProperties = PrepareAlbumModel()
                            albumProperties.image = arr.element.image
                            albumProperties.caption = caption
                            albumProperties.date = date
                            albumProperties.index = arr.offset
                            album.images.insert(albumProperties, at: arr.offset)
                            realm.add(album)
                            
                        }
                    }
                    
                } else {
                    
                    if let album = album {
                        
                        try! realm.write {
                            
                            album.coverImage = coverImageIndex
                            album.images.remove(at: arr.offset)
                            let albumProperties = PrepareAlbumModel()
                            albumProperties.image = arr.element.image
                            albumProperties.caption = caption
                            albumProperties.date = date
                            albumProperties.index = arr.offset
                            album.images.insert(albumProperties, at: arr.offset)
                            
                            realm.add(album)
                            
                        }
                    }
                }
            }
            collectionView?.reloadData()
            
        } else {
            
            for arr in album!.images.enumerated() {
                if arr.offset == index {
                    
                    if let album = album {
                        
                        try! realm.write {
                            
                            album.coverImage = coverImageIndex
                            album.images.remove(at: arr.offset)
                            let albumProperties = PrepareAlbumModel()
                            albumProperties.image = arr.element.image
                            albumProperties.caption = caption
                            albumProperties.date = date
                            albumProperties.index = arr.offset
                            album.images.insert(albumProperties, at: arr.offset)
                            
                            realm.add(album)
                            
                        }
                    }
                }
            }
            collectionView?.reloadData()
        }
    }
}
