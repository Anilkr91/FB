//
//  CheckOutTableViewController.swift
//  FunBook
//
//  Created by admin on 23/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit
import Gloss
import Alamofire
import RealmSwift

class CheckOutTableViewController: BaseTableViewController {
    
    var album: AlbumModel?
    var object: AlbumTypeDetailModel?
    var shippingObject: ShippingModel?
    var albumQuantity: Int?
    var priceTotal: Double = 0.0
    var albumAmount: Double = 0.0
    var shippingPrice: Double = 0.0
    var paypalResponseId: String = ""
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var shippingType: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var checkoutButton: UIButton!
    
    let unchecked = UIImage(named: "empty-circle" )
    let checked = UIImage(named: "check-circle")
    
    var isChecked: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectButton.setImage(checked, for: .normal)
        
        if let object = object {
            priceLabel.text = object.amount
            
            if let albumPrice = Double(object.amount) {
                albumAmount = albumPrice
            }
        }
        
        if let shippingObject = shippingObject {
            shippingType.text = shippingObject.shippingTitle
            
            if let shippingAmount = Double(shippingObject.shippingAmount) {
                shippingPrice = shippingAmount
            }
        }
        
        if let albumQuantity =  albumQuantity {
            quantityLabel.text = "\(albumQuantity)"
        }
        priceTotal = Double(albumQuantity!) * (albumAmount + shippingPrice)
        
        print(priceTotal)
        totalPrice.text = "\(priceTotal)"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PaypalConfig.connectEnvironment()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkoutButtonTapped(_ sender: Any) {
        
        if isChecked == false {
            showAlert("Error", message: "Accept Terms and Conditions")
            
        } else {
            let config =  PaypalConfig.setPayPalMerchant()
            let paymentProcessing =   PaypalConfig.setPayPalBuying(itemName: album!.name , itemPrice: "\(priceTotal)")
            
            if (paymentProcessing.processablePay) {
                let paymentViewController = PayPalPaymentViewController(payment: paymentProcessing.payment, configuration: config, delegate: self)
                self.present(paymentViewController!, animated: true, completion: nil)
            } else {
                print("notprocessable:\(paymentProcessing.payment)")
            }
        }
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
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        
        if isChecked == true {
            selectButton.setImage(unchecked, for: UIControlState.normal)
            isChecked = false
            
        } else {
            selectButton.setImage(checked, for: UIControlState.normal)
            isChecked = true
        }
    }
}

extension CheckOutTableViewController: PayPalPaymentDelegate {
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        paymentViewController.dismiss(animated: true) {
            
            let json = PaypalResponse(json: completedPayment.confirmation as! JSON)
            
            if let json = json {
                
                if json.state == "approved" {
                    self.paypalResponseId = json.id
                    self.showSucessAlert("Paypal Status \(json.state)", message: "Response id: \(json.id)")
                    
                } else if json.state == "failed" || json.state == "canceled" || json.state == "expired" {
                    
                    self.showAlert("Paypal Status \(json.state)", message: "Response id: \(json.id)")
                    
                }
            }
        }
    }

//    paymentId,albumName,addressID,albumType,quantity,shippingCharges,price,totalPrice,albumDate(dd-mm-yyyy),imageDate[](dd-mm-yyyy),gallery[],caption[],coverImage
    
    
    func uploadAlbum(param: AlbumTransformerModel) {
        print(param)
        let user = LoginUtils.getCurrentMemberUserLogin()!
        let URL = Constants.BASE_URL
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY,
                                   "userToken": user.userToken,
                                   "userID": user.userID ]
        
        
        let r =  Alamofire.upload(multipartFormData: { multipartFormData in
            for img in param.images.enumerated() {
                
                
                if let imageData = img.element.image.jpeg(.highest) {
                    multipartFormData.append(imageData, withName: "gallery[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    multipartFormData.append(img.element.caption.data(using: String.Encoding.utf8)!, withName: "caption[]")
                    multipartFormData.append(img.element.date.data(using: String.Encoding.utf8)!, withName: "imageDate[]")
                }
            }
            
            multipartFormData.append(param.name.data(using: String.Encoding.utf8)!, withName: "albumName")
            multipartFormData.append(param.description.data(using: String.Encoding.utf8)!, withName: "albumDescription")
            multipartFormData.append(param.date.data(using: String.Encoding.utf8)!, withName: "albumDate")
            multipartFormData.append(param.addressId.data(using: .utf8)!, withName: "addressID")
            
            // TODO: Mark (Remove static address id
            
            if let quantity = self.albumQuantity {
                multipartFormData.append("\(quantity)".data(using: .utf8)!, withName: "quantity")
            }
            
            if let albumType = self.object  {
                multipartFormData.append("\(albumType.amount)".data(using: .utf8)!, withName: "price")
                multipartFormData.append("\(albumType.id)".data(using: .utf8)!, withName: "albumType")
            }
            
            multipartFormData.append(self.paypalResponseId.data(using: .utf8)!, withName: "paymentId")
            multipartFormData.append("\(1)".data(using: .utf8)!, withName: "shippingCharges")
            multipartFormData.append("\(self.priceTotal)".data(using: .utf8)!, withName: "totalPrice")
            multipartFormData.append("\(param.coverImage)".data(using: String.Encoding.utf8)!, withName: "coverImage")
            
        },
                                  usingThreshold:UInt64.init(),
                                  to: URL + "profile/create_album",
                                  method:.post,
                                  headers: header,
                                  
                                  encodingCompletion: { encodingResult in
                                    debugPrint(request)
                                    switch encodingResult {
                                    case .success(let upload, _, _):
                                        debugPrint(upload)
                                        upload.responseJSON { response in
                                            print(response)
                                            self.deleteAlbumFromLocalDB()
                                            
                                        }
                                    case .failure(let error):
                                        print(error)
                                    }
                                    
        })
        debugPrint(r)
    }
    
    func showSucessAlert(_ title: String, message: String) {
        
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Upload Now", style: .default) { (action:UIAlertAction!) in
            
            if let album = self.album {
                
                var param =  AlbumTransformerModel(coverImage: album.coverImage, name: album.name, description: album.definition, date: album.date, addressId: album.addressId, images: [])
                
                for image in album.images.enumerated() {
                    let img = UIImage(data: image.element.image!)
                    
                    let obj = PrepareAlbumTransformerModel(image: img!, caption: image.element.caption, date: image.element.date, index: image.element.index)
                    param.images.append(obj)
                }
//                self.saveAlbumtoRealmDB()
                self.uploadAlbum(param: param)
            }
        }
        
        let laterAction = UIAlertAction(title: "Upload Later", style: .default) { (action:UIAlertAction!) in
            self.saveAlbumtoRealmDB()
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        
        alertView.addAction(OKAction)
        alertView.addAction(laterAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func deleteAlbumFromLocalDB() {
        
        if let album = self.album {
            
            let realm = try! Realm()
            try! realm.write {
                realm.delete(album)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func saveAlbumtoRealmDB() {
        
        let realm = try! Realm()
        try! realm.write {
            
            if let object = object {
                album!.albumPrice = object.amount
            }
            album!.albumTotalPrice = "\(priceTotal)"
            album!.status = AlbumStatus.PaymentComplete.rawValue
            realm.add(album!)
        }
    }
}
