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
    func dataFound(GoogleVisions : [GoogleVision])
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
    
    func GoogleVisionUsingCodable(with image: UIImage){
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
        let task = URLSession.shared.dataTask(with: request) {(data ,response, error) in
            
            
            //check for valid response with 200 (success)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                self.delegate?.dataNotFound(reason: .networkRequestFailed)
                
                return
            }
            
            //ensure data is non-nil
            guard let data = data else {
                self.delegate?.dataNotFound(reason: .noData)
                
                return
            }
            
            let decoder = JSONDecoder()
            let decodedRoot = try? decoder.decode(Root.self, from: data)
            
            
            
            //ensure json structure matches our expections and contains a venues array
            guard let root = decodedRoot else {
                self.delegate?.dataNotFound(reason: .badJSONResponse)
                
                return
            }
            
            
            let  LabelAnnotations = root.responses.description
            
            var GoogleVisions = [GoogleVision]()
            for LabelAnnotation in LabelAnnotations{
                
                let des = GoogleVision(description : LabelAnnotation.description)
                GoogleVisions.append(des)
                
            }
            
            self.delegate?.dataFound(GoogleVisions: GoogleVisions)
        }
        
        task.resume()
        
    }
    
}
