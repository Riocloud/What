//
//  PhotoIDViewController.swift
//  What
//
//  Created by Will on 12/16/17.
//  Copyright © 2017 Will. All rights reserved.
//

import Foundation
import UIKit
class PhotoIDViewController: UIViewController {
    let google = GoogleVisionAPIManager()

   var newImage = UIImage()
   
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageView != nil {
            imageView.image = newImage
        }
    }
}
