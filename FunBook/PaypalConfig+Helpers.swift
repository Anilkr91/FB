//
//  PaypalConfig+Helpers.swift
//  FunBook
//
//  Created by admin on 23/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import UIKit

var environment:String = PayPalEnvironmentSandbox {
    willSet(newEnvironment) {
        if (newEnvironment != environment) {
            PayPalMobile.preconnect(withEnvironment: newEnvironment)
        }
    }
}

class PaypalConfig {
    
    class func setPayPalMerchant() -> PayPalConfiguration {
        let config = PayPalConfiguration()
        let url: String = "https://www.paypal.com/webapps/mpp/ua/privacy-full"
        let url2: String = "https://www.paypal.com/webapps/mpp/ua/useragreement-full"
        config.acceptCreditCards = true
        config.merchantPrivacyPolicyURL = URL(string: url)
        config.merchantUserAgreementURL = URL(string: url2)
        config.languageOrLocale = Locale.preferredLanguages[0]
        config.payPalShippingAddressOption = .payPal
        return config
    }
    
    class func setPayPalBuying(itemName: String, itemPrice: String) -> (processablePay: Bool, payment: PayPalPayment) {
        let item1 = PayPalItem(name: itemName, withQuantity: 1, withPrice: NSDecimalNumber(string: itemPrice), withCurrency: "USD", withSku: "")
        let items = [item1]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        let payment = PayPalPayment(amount: subtotal, currencyCode: "USD", shortDescription: "Album1", intent: .authorize)
        payment.items = items
        return (payment.processable, payment)
    }
    
    class func connectEnvironment() {
        PayPalMobile.preconnect(withEnvironment: environment)
    }
}
