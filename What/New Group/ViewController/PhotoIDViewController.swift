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
class PhotoIDViewController: UIViewController,UITableViewDelegate {
    var GoogleVisions = [GoogleVision]()
    var newImage = UIImage()
   
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var GoogleResult: UITableView!
    //Google.GoogleVisionUsingCodable(with : theImagePassed)
    
    func dataProcess(image : UIImage){
        Google.GoogleVisionUsingCodable(with: image)
    }
    
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GoogleVisions.count
    }
    
    
    private func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dataProcess(image: theImagePassed)
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoogleCell", for: indexPath) as UITableViewCell
        
        // Configure the cell...
        let g = GoogleVisions[indexPath.row]
        
        cell.textLabel?.text = g.description
        
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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoogleResult.delegate = self
        GoogleResult.dataSource = self as? UITableViewDataSource
        Google.delegate = self as? GoogleVisionAPIDelegate
        if imageView != nil {
            imageView.image = newImage
        }
    }
}
