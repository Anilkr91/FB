//
//  SelectedImagesCollectionViewController.swift
//  FunBook
//
//  Created by admin on 09/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class SelectedImagesCollectionViewController: BaseCollectionViewController {
    
    var album: AlbumModel?
    var object: PrepareAlbumModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        object = album!.images[indexPath.item]
        performSegue(withIdentifier: "showImageSegue", sender: self)
        
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showAlbumTypeSegue", sender: self)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showImageSegue" {
            
            let nvc = segue.destination as? UINavigationController
            let dvc = nvc?.viewControllers[0] as? ImageOperationsTableViewController
            dvc?.delegate = self
            dvc?.coverImageIndex = album?.coverImage
            dvc?.object = object
        
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
        //        let captions = ["Caption1", "Caption2", "Caption3", "Caption4"]
        let URL = Constants.BASE_URL
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY,
                                   "userToken": user.userToken,
                                   "userID": user.userID ]
        
        let r =  Alamofire.upload(multipartFormData: { multipartFormData in
            
            
            //            gallery[],caption[],albumName,albumDescription,albumDate(YYYY-MM-DD),addressID,imageDate[],coverImage(default 0)
            
            for img in param.images.enumerated() {
                
                if let imageData = img.element.image.jpeg(.highest)  {
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
        album!.coverImage = coverImageIndex
    
        if isCopyToAll == true {
            
            for arr in album!.images.enumerated() {
                if arr.offset == index {
                    //                    album!.images.remove(at: arr.offset)
                    album!.images.remove(at: arr.offset)
                    album!.images.insert(PrepareAlbumModel(image: arr.element.image, caption: caption, date: date, index: arr.offset), at: arr.offset)
                    
                } else {
                    album!.images.remove(at: arr.offset)
                    album!.images.insert(PrepareAlbumModel(image: arr.element.image, caption: caption, date: "", index: arr.offset), at: arr.offset)
                }
            }
            print(album)
            collectionView?.reloadData()
            
        } else {
            
            for arr in album!.images.enumerated() {
                if arr.offset == index {
                    album!.images.remove(at: arr.offset)
                    album!.images.insert(PrepareAlbumModel(image: arr.element.image, caption: caption, date: date, index: arr.offset), at: arr.offset)
                    
                }
            }
            print(album)
            collectionView?.reloadData()
        }
    }
}
