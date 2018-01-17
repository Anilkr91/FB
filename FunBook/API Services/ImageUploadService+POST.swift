//
//  ImageUploadService+POST.swift
//  FunBook
//
//  Created by admin on 05/01/18.
//  Copyright © 2018 Techximum. All rights reserved.
//

import Alamofire
import Gloss

class UploadImagePostService {
    static func executeRequest (_ data: Data, image: String, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        
        let user = LoginUtils.getCurrentMemberUserLogin()!
        
        let header: HTTPHeaders = ["APIAUTH" : Constants.API_KEY,
                                   "userToken": user.userToken,
                                   "userID": user.userID ]

         let URL = Constants.BASE_URL
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request =  manager.upload(multipartFormData:{ multipartFormData in
            
            multipartFormData.append(data, withName: "profilePic", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpg")
            
        },
                                      usingThreshold:UInt64.init(),
                                      to: URL + "profile/userImage",
                                      method:.post,
                                      headers: header,
                                      encodingCompletion: { encodingResult in
                                        
                                        switch encodingResult {
//                                             debugPrint(request)
                                        case .success(let upload, _, _):
                                            debugPrint(upload)
                                            upload.responseJSON { response in
//                                                ProgressBarView.hideHUD()
                                                print(response)
                                                
                                            }
                                            
                                        case .failure(let encodingError):
                                            print(encodingError)
                                        }
        })
        debugPrint(request)
    }
}
