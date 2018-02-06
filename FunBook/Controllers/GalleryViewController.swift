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

    var albumName: String = ""
    var album: AlbumResponseModel?
    var albumModel: [AlbumResponseModel] = []
    @IBOutlet weak var tableview: UITableView!
    
     let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
         getAlbumFromRealmDB()    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //fetch all albums
//        getAllAlbums()
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

extension GalleryViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "showAlbumDetail" {
            
            let dvc = segue.destination as! AlbumDetailTableViewController
            dvc.navigationItem.title = album?.albumName
            dvc.albumId = album!.albumID
        }
    }
    
//    func getAllAlbums() {
//
//        AlbumListingGetService.executeRequest(vc: self) { (response) in
//            print(response)
//            self.albumModel = response
//            self.tableview.reloadData()
//        }
//    }
    
    func getAlbumFromRealmDB() {
        
        do {
            let albums = realm.objects(AlbumModel.self)
            print(albums)
        }
    }
    
    func deleteObjectFromRealmDB() {
        let albums = realm.objects(AlbumModel.self)
        
        try! self.realm.write({
            realm.delete(albums[0])
        })
    }
}
