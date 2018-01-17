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
    
    func didAddCaptionWithDate(caption: String, date: String, index: Int)
}

class ImageOperationsTableViewController: BaseTableViewController {
    
    var delegate: passAlbumDataDelegte?
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var selectDateTextField: UITextField!
    
    var object: PrepareAlbumModel?
    lazy var datePicker = UIDatePicker()
    let dateFormatter = "YYYY-MM-dd"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBarButton()
        datePicker.datePickerMode = .date
        selectDateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(ImageOperationsTableViewController.getDate(sender:)), for: UIControlEvents.valueChanged)

        // Do any additional setup after loading the view.
        
        if let object = object {
            albumImageView.image = object.image
            captionTextField.text = object.caption 
            selectDateTextField.text = object.date
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
    
    func setupBarButton() {
        
        let rightBarButton = UIBarButtonItem(title: "Dismiss", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ImageOperationsTableViewController.dismissController))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func dismissController() {
        self.dismiss(animated: true, completion: nil)
        
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
            self.delegate?.didAddCaptionWithDate(caption: caption, date: date, index: self.object!.index)
            
        }
    }
}
