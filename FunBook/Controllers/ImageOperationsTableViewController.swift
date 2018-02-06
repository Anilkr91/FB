//
//  ImageOperationsTableViewController.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import SwiftDate

protocol passAlbumDataDelegte {
    func didAddCaptionWithDate(caption: String, date: String, index: Int, isCopyToAll: Bool, coverImageIndex: Int)
}

class ImageOperationsTableViewController: BaseTableViewController, CropViewControllerDelegate {
    
    var delegate: passAlbumDataDelegte?
    var albumProperties: PrepareAlbumModel?
    var isCaptionAll: Bool = false
    var coverImageIndex: Int?
    
    // Crop Properties
    private var image: UIImage?
    private var croppingStyle = CropViewCroppingStyle.default
    private var croppedRect = CGRect.zero
    private var croppedAngle = 0
    
    // IBOutlets
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var selectDateTextField: UITextField!
    @IBOutlet weak var captionSwitch: UISwitch!
    @IBOutlet weak var coverImageSwitch: UISwitch!
    
    lazy var datePicker = UIDatePicker()
    let dateFormatter = "yyyy-MM-dd"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.datePickerMode = .date
        selectDateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(ImageOperationsTableViewController.getDate(sender:)), for: UIControlEvents.valueChanged)
        captionSwitch.addTarget(self, action: #selector(ImageOperationsTableViewController.stateChanged(sender:)), for: UIControlEvents.valueChanged)
        coverImageSwitch.addTarget(self, action: #selector(ImageOperationsTableViewController.setCoverImage(sender:)), for: UIControlEvents.valueChanged)
        
        // Do any additional setup after loading the view.
        
        if let object = albumProperties {
            
            let image = UIImage(data: object.image!)
            
            albumImageView.image = image
            captionTextField.text = object.caption 
            selectDateTextField.text = object.date
            
            if object.index == coverImageIndex {
                coverImageSwitch.isOn = true
                
            } else {
                coverImageSwitch.isOn = false
            }
        }
    }
    
    func stateChanged(sender: UISwitch) {
        if sender.isOn {
            isCaptionAll = true
        } else {
            isCaptionAll = true
        }
    }
    
    func setCoverImage(sender: UISwitch) {
        if sender.isOn {
            if let albumProperties = albumProperties {
                coverImageIndex = albumProperties.index
            }
        } else {
            coverImageIndex = 0
        }
    }
    
    func getDate(sender: Any) {
        let selectedDate =  datePicker.date
        let dateString =  selectedDate.string(custom: dateFormatter)
        selectDateTextField.text = dateString
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        let caption = captionTextField.text! 
        let date = selectDateTextField.text!
        
        self.dismiss(animated: true) {
            
            self.delegate?.didAddCaptionWithDate(caption: caption, date: date, index: self.albumProperties!.index, isCopyToAll: self.isCaptionAll, coverImageIndex: self.coverImageIndex!)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func editImageButtonTapped(_ sender: Any) {
        
        if let albumProperties = albumProperties {
            
            let image =  albumProperties.image
            let cropController = CropViewController(croppingStyle: croppingStyle, image: UIImage(data: image!)!)
            cropController.delegate = self
            self.image = UIImage(data: image!)
            self.present(cropController, animated: true, completion: nil)
        }
    }
}
