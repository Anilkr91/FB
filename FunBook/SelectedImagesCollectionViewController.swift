//
//  SelectedImagesCollectionViewController.swift
//  FunBook
//
//  Created by admin on 09/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
//import Gallery

private let reuseIdentifier = "Cell"

class SelectedImagesCollectionViewController: UICollectionViewController {
    
    var array: [PrepareAlbumModel] = []
    var object: PrepareAlbumModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(array)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("view will appear")
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return array.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SelectedImageCollectionViewCell
        
        print(array[indexPath.item])
        
        cell.info = array[indexPath.item]
//        cell.label.text = "\(indexPath.item)"
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        object = array[indexPath.item]
        performSegue(withIdentifier: "showImageSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showImageSegue" {
            
            let nvc = segue.destination as? UINavigationController
            let dvc = nvc?.viewControllers[0] as? ImageOperationsTableViewController
            dvc?.delegate = self
            dvc?.object = object
            
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
    
    func didAddCaptionWithDate(caption: String, date: String, index: Int) {
        
        for arr in array.enumerated() {
            
            if arr.offset == index {
                array.remove(at: arr.offset)
                array.insert(PrepareAlbumModel(image: arr.element.image, caption: caption, date: date, index: arr.offset), at: arr.offset)
                
            }
        }
        collectionView?.reloadData()
    }
}
