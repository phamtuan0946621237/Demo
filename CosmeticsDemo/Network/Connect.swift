//
//  Service.swift
//  PokemonCard
//
//  Created by admin on 12/21/20.
//

import Foundation
import Alamofire

class Connect {
    var url = "http://localhost:8001/"
    func getHeader(token : String?) -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "X-FIIN-CLIENT-OS": "pwa",
            "X-FIIN-APP-VERSION": "1.0.0",
            "Authentication": "Bearer \(token ?? "")"
        ]
        return headers
    }
//    let parameters: [String: String] = ["search": "hello"]

//    fileprivate var baseUrl = ""
    typealias ResCallback = (_ data : [String : Any]?) -> Void
    var callBack : ResCallback?
//    init(baseUrl : String) {
//        self.baseUrl = baseUrl
//    }
    func completionHandler(callBack : @escaping ResCallback) {
        self.callBack = callBack
    }
    func fetchPost(endPoint : String,token : String?,parram : [String: String]?) {
        AF.request(self.url + endPoint,method: .post,parameters: parram , encoding: URLEncoding.default,headers: nil,interceptor: nil).responseJSON { (response) in
            if let jsonObj = response.value as? [String : Any] {
                                self.callBack?(jsonObj as? [String : Any] )
            }
        }
    }
    
    func fetchGet(endPoint : String,token : String?,parram : [String: String]?) {
        AF.request(self.url + endPoint,method: .get,parameters: parram , encoding: URLEncoding.default,headers: nil,interceptor: nil).responseJSON { (response) in
            if let jsonObj = response.value as? [String : Any] {
                print("fooeflwe : ",jsonObj)
                                self.callBack?(jsonObj as? [String : Any] )
            }
        }
    }
}
