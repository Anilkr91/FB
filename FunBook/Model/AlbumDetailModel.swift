//
//  AlbumDetailModel.swift
//  FunBook
//
//  Created by admin on 15/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Gloss

struct AlbumDetailModel: JSONDecodable {
    
    let address: String
    let albumAmount: String
    let albumDate: String
    let albumDescription: String
    let albumID: String
    let albumName: String
    let albumPages: String
    let albumPaperName: String
    let albumPaperSize: String
    let blankPages: String
    let createTime: String
    let created: String
    let currency: String
    let name: String
    let paymentID: String
    let paymentMethod: String
    let paypalId: String
    let paypalAmount: String
    let price: String
    let printPages: String
    let quantity: String
    let shippingName: String
    let shippingPrice: String
    let state: String
    let thumb: String
    let totalPrice: String
    
    init?(json: JSON) {
        
        guard let address: String  =  "address" <~~ json,
            let albumAmount: String  = "albumAmount" <~~ json,
            let albumDate: String  = "albumDate" <~~ json,
            let albumDescription: String  = "albumDescription" <~~ json,
            let albumID: String  = "albumID"  <~~ json,
            let albumName: String = "albumName"  <~~ json,
            let albumPages: String = "albumPages"   <~~ json,
            let albumPaperName: String  = "albumPaperName"  <~~ json,
            let albumPaperSize: String = "albumPaperSize"  <~~ json,
            let blankPages: String = "blankPages"  <~~ json,
            let createTime: String = "create_time"  <~~ json,
            let created: String  = "created"  <~~ json,
            let currency: String =  "currency"  <~~ json,
            let name: String  = "name" <~~ json,
            let paymentID: String = "paymentID" <~~ json,
            let paymentMethod: String = "payment_method" <~~ json,
            let paypalId: String = "paypalId" <~~ json,
            let paypalAmount: String = "paypal_amount" <~~ json,
            let price: String = "price" <~~ json,
            let printPages: String = "printPages" <~~ json,
            let quantity: String = "quantity" <~~ json,
            let shippingName: String =  "shippingName" <~~ json,
            let shippingPrice: String =  "shippingPrice" <~~ json,
            let state: String = "state" <~~ json,
            let thumb: String = "thumb" <~~ json,
            let totalPrice: String = "totalPrice"  <~~ json else { return nil }
        
        self.address = address
        self.albumAmount = albumAmount
        self.albumDate = albumDate
        self.albumDescription = albumDescription
        self.albumID = albumID
        self.albumName = albumName
        self.albumPages = albumPages
        self.albumPaperName = albumPaperName
        self.albumPaperSize = albumPaperSize
        self.blankPages = blankPages
        self.createTime = createTime
        self.created = created
        self.currency = currency
        self.name = name
        self.paymentID = paymentID
        self.paymentMethod = paymentMethod
        self.paypalId = paypalId
        self.paypalAmount = paypalAmount
        self.price = price
        self.printPages = printPages
        self.quantity = quantity
        self.shippingName = shippingName
        self.shippingPrice = shippingPrice
        self.state = state
        self.thumb = thumb
        self.totalPrice = totalPrice
        
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            "address" ~~> self.address,
            "albumAmount" ~~> self.albumAmount,
            "albumDate" ~~> self.albumDate,
            "albumDescription" ~~> self.albumDescription,
            "albumID"  ~~> self.albumID,
            "albumName"  ~~> self.albumName,
            "albumPages"   ~~> self.albumPages,
            "albumPaperName"  ~~> self.albumPaperName,
            "albumPaperSize"  ~~> self.albumPaperSize,
            "blankPages" ~~> self.blankPages,
            "create_time"  ~~> self.createTime,
            "created"  ~~> self.created,
            "currency"  ~~> self.currency,
            "name" ~~> self.name,
            "paymentID" ~~> self.paymentID,
            "payment_method" ~~> self.paymentMethod,
            "paypalId" ~~> self.paypalId,
            "paypal_amount" ~~> self.paypalAmount,
            "price" ~~> self.price,
            "printPages" ~~> self.printPages,
            "quantity" ~~> self.quantity,
            "shippingName" ~~> self.shippingName,
            "shippingPrice" ~~> self.shippingPrice,
            "state" ~~> self.state,
            "thumb" ~~> self.thumb,
            "totalPrice" ~~> self.totalPrice
            
            ])
    }
}
