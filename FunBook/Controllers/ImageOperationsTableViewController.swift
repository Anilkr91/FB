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
    func didAddCaptionWithDate(image: Data?, caption: String, date: String, index: Int, isCopyToAll: Bool, coverImageIndex: Int)
}

class ImageOperationsTableViewController: BaseTableViewController {
    
    var delegate: passAlbumDataDelegte?
    var albumProperties: PrepareAlbumModel?
    var isCaptionAll: Bool = false
    var coverImageIndex: Int?
    var imageData: Data?
    
    // Crop Properties
    private var image: UIImage?
    let imageView = UIImageView()
    private var croppingStyle = CropViewCroppingStyle.default
    var croppedRect = CGRect.zero
    var croppedAngle = 0
    
    // IBOutlets
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var selectDateTextField: UITextField!
    @IBOutlet weak var captionSwitch: UISwitch!
    @IBOutlet weak var coverImageSwitch: UISwitch!
    
    lazy var datePicker = UIDatePicker()
    let dateFormatter = "dd-MM-yyyy"
    
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
            
            self.delegate?.didAddCaptionWithDate(image: self.imageData, caption: caption, date: date, index: self.albumProperties!.index, isCopyToAll: self.isCaptionAll, coverImageIndex: self.coverImageIndex!)
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
            print(self.image)
            self.present(cropController, animated: true, completion: nil)
        }
    }
}

extension ImageOperationsTableViewController: CropViewControllerDelegate {
    
    public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
        print(image)
        print(angle)
        imageData = UIImagePNGRepresentation(image)
        albumImageView.image = image
        cropViewController.dismiss(animated: true, completion: nil)
//        self.croppedRect = cropRect
//        self.croppedAngle = angle
//        updateImageViewWithImage(image, fromCropViewController: cropViewController)
    }
    
    public func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
        imageView.image = image
        layoutImageView()
        
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
        if cropViewController.croppingStyle != .circular {
            imageView.isHidden = true
            
            cropViewController.dismissAnimatedFrom(self, withCroppedImage: image,
                                                   toView: imageView,
                                                   toFrame: CGRect.zero,
                                                   setup: { self.layoutImageView() },
                                                   completion: { self.imageView.isHidden = false })
        }
        else {
            self.imageView.isHidden = false
            cropViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    public func layoutImageView() {
        guard imageView.image != nil else { return }
        
        let padding: CGFloat = 20.0
        
        var viewFrame = self.view.bounds
        viewFrame.size.width -= (padding * 2.0)
        viewFrame.size.height -= ((padding * 2.0))
        
        var imageFrame = CGRect.zero
        imageFrame.size = imageView.image!.size;
        
        if imageView.image!.size.width > viewFrame.size.width || imageView.image!.size.height > viewFrame.size.height {
            let scale = min(viewFrame.size.width / imageFrame.size.width, viewFrame.size.height / imageFrame.size.height)
            imageFrame.size.width *= scale
            imageFrame.size.height *= scale
            imageFrame.origin.x = (self.view.bounds.size.width - imageFrame.size.width) * 0.5
            imageFrame.origin.y = (self.view.bounds.size.height - imageFrame.size.height) * 0.5
            imageView.frame = imageFrame
        }
        else {
            self.imageView.frame = imageFrame;
            self.imageView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        }
    }
}
