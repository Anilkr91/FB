//
//  AlbumInformationTableViewController.swift
//  FunBook
//
//  Created by admin on 17/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import OpalImagePicker
import Photos
import RealmSwift

class AlbumInformationTableViewController: BaseTableViewController {
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var albumDescriptionTextField: UITextField!
    @IBOutlet weak var selectDateTextField: UITextField!
    var album = AlbumModel()
    
    lazy var datePicker = UIDatePicker()
//    slet dateFormatter = "dd-MM-yyyy"
    let dateFormatter = "yyyy-MM-dd"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        datePicker.datePickerMode = .date
        selectDateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(ImageOperationsTableViewController.getDate(sender:)), for: UIControlEvents.valueChanged)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDate(sender: Any) {
        let selectedDate =  datePicker.date
        let dateString =  selectedDate.string(custom: dateFormatter)
        selectDateTextField.text = dateString
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        let albumName = albumNameTextField.text!
        let description =  albumDescriptionTextField.text!
        let date = selectDateTextField.text!
        
        if albumName.removeAllSpaces().isEmpty {
            showAlert("Error", message: "Album Namecannot be empty")
            
        }  else  {
            
            album.name = albumName
            album.definition = description
            album.date = date
            openOpalImagePicker()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
}

extension AlbumInformationTableViewController: OpalImagePickerControllerDelegate {
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        
        album.images.removeAll()
        
        for image in images.enumerated() {
            
            let imageData = UIImagePNGRepresentation(image.element)

            let albumProperties = PrepareAlbumModel()
            albumProperties.caption = ""
            albumProperties.date = ""
            albumProperties.image = imageData
            albumProperties.index = image.offset
            
            album.images.append(albumProperties)
//            album.images.insert(albumProperties, at: image.offset)
        }
       
        picker.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "showSelectedImagesSegue", sender: self)
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
        print(assets)
        
    }
    
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showSelectedImagesSegue" {
            let dvc = segue.destination as! SelectedImagesCollectionViewController
            
            dvc.album = album
            dvc.galleryVC = nil
//            dvc.navigationItem.title = album.name
            
        }
    }
}
