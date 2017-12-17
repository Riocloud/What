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
class PhotoIDViewController: UIViewController {
    
   var newImage = UIImage()
   
    
 
    @IBOutlet weak var imageView: UIImageView!
    
    //Google.GoogleVisionUsingCodable(with : theImagePassed)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageView != nil {
            imageView.image = newImage
        }
    }
}
