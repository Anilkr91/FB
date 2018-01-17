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

class AlbumInformationTableViewController: BaseTableViewController {
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var albumDescriptionTextField: UITextField!
    @IBOutlet weak var selectDateTextField: UITextField!
    var album = AlbumModel(coverImage: 0, name: "", description: "", date: "", images: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        
        let albumName = albumNameTextField.text!
        let description =  albumDescriptionTextField.text!
        let date = selectDateTextField.text!
        
        if albumName.removeAllSpaces().isEmpty {
            showAlert("Error", message: "Album Namecannot be empty")
            
        }  else  {
         album = AlbumModel(coverImage: 0,name: albumName, description: description, date: date, images: [])
            openOpalImagePicker()
            
        }
    }
    
    func openOpalImagePicker() {
        let imagePicker = OpalImagePickerController()
        imagePicker.maximumSelectionsAllowed = 3
        
        let configuration = OpalImagePickerConfiguration()
        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You cannot select that many images!", comment: "")
        imagePicker.configuration = configuration
        
        imagePicker.imagePickerDelegate = self
        self.present(imagePicker, animated: true, completion: nil)
        
    }
}

extension AlbumInformationTableViewController: OpalImagePickerControllerDelegate {
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        
        for image in images.enumerated() {
                album.images.append(PrepareAlbumModel(image: image.element, caption: "", date: "", index: image.offset))
           
        }
        
        print(album)
        
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
           dvc.navigationItem.title = album.name
            
        }
    }
}
