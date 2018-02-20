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

    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        if let album = album {
            self.navigationItem.addTitleAndSubtitleToNavigationBar(title: album.name, subtitle: "count: \(album.images.count)")
        }
        return album!.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SelectedImageCollectionViewCell
        cell.info = album?.images[indexPath.item]
        
        let lpgesture = UILongPressGestureRecognizer(target: self, action: #selector(SelectedImagesCollectionViewController.handleLongPress(_:)))
        lpgesture.minimumPressDuration = 0.5
        lpgesture.delaysTouchesBegan = true
        lpgesture.delegate = self
        cell.addGestureRecognizer(lpgesture)
        
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
   
     func didAddCaptionWithDate(image: Data?, caption: String, date: String, index: Int, isCopyToAll: Bool, coverImageIndex: Int) {
        
        if galleryVC == nil {
            print("album information")
            
            newAlbumWithInformation(image: image, caption: caption, date: date, index: index, isCopyToAll: isCopyToAll, coverImageIndex: coverImageIndex)
            
        } else {
            print("gallery vc local db")
            
            localAlbumWithInformation(image: image, caption: caption, date: date, index: index, isCopyToAll: isCopyToAll, coverImageIndex: coverImageIndex)
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
    
    func newAlbumWithInformation(image: Data?, caption: String, date: String, index: Int, isCopyToAll: Bool, coverImageIndex: Int) {
        
        if isCopyToAll == true {
            
            for arr in album!.images.enumerated() {
                
                if arr.offset == index {
                    
                    if let album = album {
                        
                        album.coverImage = coverImageIndex
                        album.images.remove(at: arr.offset)
                        let albumProperties = PrepareAlbumModel()
                        albumProperties.image = image ?? arr.element.image
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
                         albumProperties.image = image ?? arr.element.image
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
                        albumProperties.image = image ?? arr.element.image
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
    
    func localAlbumWithInformation(image: Data?, caption: String, date: String, index: Int, isCopyToAll: Bool, coverImageIndex: Int) {
        
        if isCopyToAll == true {
            
            for arr in album!.images.enumerated() {
                
                if arr.offset == index {
                    
                    if let album = album {
                        
                        try! realm.write {
                            album.coverImage = coverImageIndex
                            album.images.remove(at: arr.offset)
                            let albumProperties = PrepareAlbumModel()
                            albumProperties.image = image ?? arr.element.image
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
                            albumProperties.image = image ?? arr.element.image
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
                            albumProperties.image = image ?? arr.element.image
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

extension SelectedImagesCollectionViewController: UIGestureRecognizerDelegate  {
    
    func handleLongPress(_ gestureReconizer: UILongPressGestureRecognizer) {
        
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let deleteAlertAction = UIAlertController(title: "Choose Actions", message: nil, preferredStyle: .actionSheet)
        
        let delete = UIAlertAction(title: "Delete photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            if let cell = gestureReconizer.view as? SelectedImageCollectionViewCell, let indexPath = self.collectionView?.indexPath(for: cell) {
                
                if let album = self.album {
                    self.realm.beginWrite()
                    
                    if indexPath.row == 0 {
                        
                        album.coverImage = 0
                        album.images.remove(at: indexPath.row)
                        
                        for arr in album.images.enumerated() {
                            album.images[arr.offset].index = arr.offset
                        }
                        try! self.realm.commitWrite()
                        
                    } else {
                        album.images.remove(at: indexPath.row)
                        try! self.realm.commitWrite()
                        
                    }
                }
                self.collectionView?.reloadData()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        deleteAlertAction.addAction(delete)
        deleteAlertAction.addAction(cancelAction)
        deleteAlertAction.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        self.present(deleteAlertAction, animated: true, completion: nil)
        
    }
}
