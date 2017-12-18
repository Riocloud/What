//
//  PhotoIDViewController.swift
//  What
//
//  Created by Will on 12/16/17.
//  Copyright © 2017 Will. All rights reserved.
//

import Foundation
import UIKit
let Google = GoogleVisionAPIManager()

protocol passValueDelegate {
    func passValue(text: String)
}


class PhotoIDViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var resultAPI = [String] ()
    var GoogleVisions = [String]()
    var newImage = UIImage()
    var delegate: passValueDelegate?

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var GoogleResult: UITableView!
    //Google.GoogleVisionUsingCodable(with : theImagePassed)
    
//    func dataProcess(image : UIImage){
//        Google.GoogleVisionUsingCodable(with: image)
//    }
    
 func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count row for tableview",resultAPI.count)
        return resultAPI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoogleCell", for: indexPath) as! GoogleTableViewCell
        
        // Configure the cell...
        let g = resultAPI[indexPath.row]
        print("in tableview",indexPath.row, " ",g)
        let dict = convertToDictionary(text: g)
      //  let valueGoogle = Array(dict!).map{$0 == "description"}
        print(dict)
        print("111")
        let valueGoogle = dict!["description"] as? String
        cell.cellLabel?.text = valueGoogle
        
        
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        performSegue(withIdentifier: "Ta", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Ta"  {
            print("here to prepare picture")
            let dvc = segue.destination as! PhotoDetailsViewController
            dvc.ImageShare = newImage
            //如何传送文字过去？
           // dvc.NameLabel = ???
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if imageView != nil {
            imageView.image = newImage
        }
        Google.delegate = self as? GoogleVisionAPIDelegate
        
    }
}
