//
//  GoogleVisionAPIManager.swift
//  What
//
//  Created by Will on 12/15/17.
//  Copyright © 2017 Will. All rights reserved.
//

import Foundation
import UIKit
protocol GoogleVisionAPIDelegate {
    func dataFound(GoogleVisions : [GoogleVisionR])
    func dataNotFound(reason: GoogleVisionAPIManager.FailureReason)
}
enum FailureReason: String {
    case networkRequestFailed = "Your request failed, please try again."
    case noData = "No gym data received"
    case badJSONResponse = "Bad JSON response"
}

func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
    UIGraphicsBeginImageContext(imageSize)
    image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    let resizedImage = UIImagePNGRepresentation(newImage!)
    UIGraphicsEndImageContext()
    return resizedImage!
}


func base64EncodeImage(_ image: UIImage) -> String {
    var imagedata = UIImagePNGRepresentation(image)
    
    // Resize the image if it exceeds the 2MB API limit
    if (imagedata?.count > 2097152) {
        let oldSize: CGSize = image.size
        let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
        imagedata = resizeImage(newSize, image: image)
    }
    
    return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

class GoogleVisionAPIManager {
    enum FailureReason: String {
        case networkRequestFailed = "Your request failed, please try again."
        case noData = "No data received"
        case badJSONResponse = "Bad JSON response"
    }
    var delegate: GoogleVisionAPIDelegate?
    
    func GoogleVisionUsingCodable(with image: UIImage ,completion: @escaping ([GoogleVisionR]) -> ()){
        let googleAPIKey = "AIzaSyBOW3eZXq1cYCADkOYq2RQzJ_KkFL0JxbY"
        let urlComponents = URLComponents(string:"https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKey)")!
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        let ImageData = base64EncodeImage(image)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        // Build our API request
        let jsonRequest = [
            "requests": [
                "image": [
                    "content": ImageData
                ],
                "features": [
                    [
                        "type": "LABEL_DETECTION",
                        "maxResults": 10
                    ]
                ]
            ]
        ]
        do {
            let jsonObject = try JSONSerialization.data(withJSONObject: jsonRequest,options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = jsonObject}
        catch{
            print(error.localizedDescription)
        }
        
        
        var descrip = String()
        var score = Float()
        var googleResults = [GoogleVisionR]()
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            //print(NSString(data:data,encoding: String.Encoding.utf8.rawValue) ?? "nothing" )
            
            if let googleJsonDic = try? JSONSerialization.jsonObject(with: data, options: []){
                
                if let JsonDic = googleJsonDic as? [String:Any] { //json data is an array of dictionaries
                    
                    if let responses = JsonDic["responses"] as? [[String:Any]]{
                        
                        for labelAnnotations in responses {
                            if let googleResultObjects  = labelAnnotations["labelAnnotations"] as? [[String:Any]] {
                                for object in googleResultObjects {
                                    let score = object["score"] as? Float ?? 0.0
                                    let title = object["description"] as? String ?? "descrip"
//                                    let googleResult = GoogleVisionR(descrip : descrip, score : score)
                                    let googleResult = GoogleVisionR(descrip : title, score : score)
                                   // let googleResults = [googleResult]()
                                    googleResults.append(googleResult)
                                }
                                completion(googleResults)
                                self.delegate?.dataFound(GoogleVisions: googleResults)
                            }
                        }
                    }else{
                        self.delegate?.dataNotFound(reason: .networkRequestFailed)
                    }
                }else{
                    self.delegate?.dataNotFound(reason: .noData)
                }
            }else{
                self.delegate?.dataNotFound(reason: .badJSONResponse)
            }
            
        }
        task.resume()
    }
        
}
        
        
        
        
        /*
        let task = URLSession.shared.dataTask(with: request) {(data ,response, error) in
            
            
            //check for valid response with 200 (success)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.delegate?.dataNotFound(reason: .networkRequestFailed)
                 print("3333")
                return
            }
            
            
            
            
            
            
            
            
            //ensure data is non-nil
            guard let data = data else {
                self.delegate?.dataNotFound(reason: .noData)
                 print("2222")
                return
            }
            
            let decoder = JSONDecoder()
            let decodedRoot = try? decoder.decode(Root.self, from: data)
            
            
            
            //ensure json structure matches our expections and contains a
            guard let root = decodedRoot else {
                self.delegate?.dataNotFound(reason: .badJSONResponse)
                print("1111")
                return
            }
            
            
            
            
            let  LabelAnnotations = root.responses.description
//            var stringArr = [String]()
            var GoogleVisions = [GoogleVision]()
            var gvResult = [String]()
            for LabelAnnotation in LabelAnnotations{
                
                let des = GoogleVision(description : LabelAnnotation.description)
                print("labelannotation->",LabelAnnotations.description)
                //let jsonData = LabelAnnotation.description
                //let decoders = JSONDecoder()
                //let beer = try?decoders.decode(Root.self, from: jsonData)
                
                gvResult.append(LabelAnnotations.description)
                GoogleVisions.append(des)
//                let splitedArray = gvResult[0].split{$0 == " "}
//                let number = splitedArray.count
//                var n = 0
//                var stringInit = " "
//                for num1 in 0..<number {
//                    stringInit = String(splitedArray[num1])
//                    if stringInit == "description:" {
//                        stringArr[n] = String(splitedArray[num1 + 1])
//                        n += 1
//                    }
//               }
                
            }
            
            self.delegate?.dataFound(GoogleVisions: GoogleVisions)
            completion(gvResult)
        }
        
        task.resume()
        
    }
 }*/


