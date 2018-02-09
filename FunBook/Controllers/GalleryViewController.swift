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
        getAlbumFromRealmDB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RealmAlbumTableViewCell
        
        cell.info = albums[indexPath.section]
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
        album = albums[indexPath.section]
        self.performSegue(withIdentifier: "showSelectedImagesSegue", sender: self)
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
//            print(albums)
        }
    }
    
    func deleteObjectFromRealmDB() {
        let albums = realm.objects(AlbumModel.self)
        
        try! self.realm.write({
            realm.delete(albums[0])
        })
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
