//
//  WikiAPIManager.swift
//  What
//
//  Created by Will on 12/16/17.
//  Copyright © 2017 Will. All rights reserved.
//

import Foundation

import Alamofire
import BrightFutures
import SwiftyJSON


internal class WikiAPIManger {
    
  func getExtract(title: String) -> Future<String?, NSError> {
        
        let promise = Promise<String?, NSError>()
        
        
        if let URL = NSURL(string: "https://en.wikipedia.org/w/api.php") {
            
            let params: [String: AnyObject] = [
                "action": "query" as AnyObject,
                "prop": "extracts|info" as AnyObject,
                "format": "json" as AnyObject,
                "exintro": true as AnyObject,
                "explaintext": true as AnyObject,
                "inprop": "url" as AnyObject,
                "redirects": true as AnyObject,
                "converttitles": true as AnyObject,
                "titles": title as AnyObject
            ]
           
          //  request(<#T##url: URLConvertible##URLConvertible#>)
            request(URL as! URLConvertible, method: .get, parameters: params, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                        
                    case .success(let data):
                        let json = JSON(data)
                        
                        var extract: String? = nil
                        if let pages = json["query"]["pages"].dictionary {
                            for (_, subJson): (String, JSON) in pages {
                                extract = subJson["extract"].string
                            }
                        }
                        
                        promise.success(extract)
                    case .failure(let error):
                        promise.failure(error as NSError)
                    }
            }
            
        } else {
            promise.failure(NSError(domain: "", code: 0, userInfo: nil))
            
        }
        
        
        return promise.future
    }
    
}
