//
//  AlbumTypeService+GET.swift
//  FunBook
//
//  Created by admin on 19/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class AlbumTypeGetService {
    static func executeRequest (vc: UIViewController, completionHandler: @escaping ([AlbumTypeModel]) -> Void) {
        
         ProgressBarView.showHUD(textString: "Fetching Album Types..")
        let user = LoginUtils.getCurrentMemberUserLogin()!
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY,
                                   "userToken": user.userToken,
                                   "userID": user.userID ]
        
        let URL = Constants.BASE_URL
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request( URL + "profile/album_type/", method: .get, parameters: nil, encoding: URLEncoding.default, headers: header).responseJSON { response in
            
            switch response.result {
                
            case .success(let value) :
                
                print(value)
                
                if let json = AlbumTypeResponseArrayModel(json: value as! JSON) {
                    completionHandler(json.data)
                    ProgressBarView.hideHUD()
                    
                    
                }
                
            case .failure(let error):
                ProgressBarView.hideHUD()
                print(error.localizedDescription)
            }
        }
        debugPrint(request)
    }
}
