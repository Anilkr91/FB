//
//  OrderDetailTableViewController.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import Kingfisher

class OrderDetailTableViewController: BaseTableViewController {
    
    var albumId: String = ""
    var albumModel: AlbumDetailModel?
    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumDateLabel: UILabel!
    @IBOutlet weak var albumDescriptionLabel: UILabel!
    @IBOutlet weak var paperNameLabel: UILabel!
    @IBOutlet weak var paperSizeLabel: UILabel!
    @IBOutlet weak var albumImageView: CircleImageView!
    
    @IBOutlet weak var receiverNameLabel: UILabel!
    @IBOutlet weak var shippingTypeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var pricePerAlbumLabel: UILabel!
    @IBOutlet weak var shippingPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var paymentIdLabel: UILabel!
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var paymentAmountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var paymentDateLabel: UILabel!
    @IBOutlet weak var paymentStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlbumDetail(albumId: albumId)
    }
    
    @IBAction func orderAgainButton(_ sender: Any) {
        let param = ["orderID": albumId]
        
        OrderAgainPostService.executeRequest(param, vc: self) { (response) in
            print(response)
        }
    }
    
    func getAlbumDetail(albumId: String) {
        AlbumDetailGetService.executeRequest(albumId, vc: self) { (response) in
            print(response)
            self.setupViews(object: response)
            self.albumModel =  response
            self.tableView.reloadData()
        }
    }
    
    func setupViews(object: AlbumDetailModel) {
        
        let imageUrl:String = object.thumb.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let url = URL(string: imageUrl)
        let placeholderImage = UIImage(named: "placeholder-profile")
        albumImageView.kf.setImage(with: url, placeholder: placeholderImage)
        
        albumNameLabel.text! = object.albumName
        albumDateLabel.text! = object.albumDate
        albumDescriptionLabel.text! = object.albumDescription
        paperNameLabel.text! = object.albumPaperName
        paperSizeLabel.text! = object.albumPaperSize
        
        receiverNameLabel.text! = object.name
        shippingTypeLabel.text! = object.shippingName
        addressLabel.text! = object.address
        
        pricePerAlbumLabel.text! = object.price
        shippingPriceLabel.text! = object.shippingPrice
        quantityLabel.text! = object.quantity
        totalPriceLabel.text! = object.totalPrice
        
        paymentIdLabel.text! = object.paypalId
        paymentMethodLabel.text! = object.paymentMethod
        paymentAmountLabel.text! = object.paypalAmount
        currencyLabel.text! = object.currency
        paymentDateLabel.text! = object.createTime
        paymentStatusLabel.text! = object.state
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.001 : 15
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            headerTitle.textLabel?.textColor = UIColor(hex: "1b99e6")
        }
    }
}
