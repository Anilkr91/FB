//
//  LogoutService+POST.swift
//  FunBook
//
//  Created by admin on 22/02/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

//import Alamofire
//import Gloss
//
//class LogoutPostService {
//    static func executeRequest (_ params:[String: Any], vc: UIViewController, completionHandler: @escaping (LoginResponseModel) -> Void) {
//        
//        ProgressBarView.showHUD(textString: "Logging Out..")
//        
//        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY]
//        let URL = Constants.BASE_URL
//        
//        let manager = Alamofire.SessionManager.default
//        manager.session.configuration.timeoutIntervalForRequest = 60
//        
//        let request = manager.request( URL + "logout", method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON { response in
//            
//            switch response.result {
//            case .success(let value) :
//                
//                print(value)
//                
//                if let json = LoginResponseModel(json: value as! JSON) {
//                    completionHandler(json)
//                    ProgressBarView.hideHUD()
//                }
//                
//            case .failure(let error):
//                ProgressBarView.hideHUD()
//                print(error.localizedDescription)
//            }
//        }
//        debugPrint(request)
//    }
//}
//
