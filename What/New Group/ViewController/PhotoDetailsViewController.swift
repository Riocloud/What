//
//  PhotoDetailsViewController.swift
//  What
//
//  Created by Will on 12/17/17.
//  Copyright © 2017 Will. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class PhotoDetailsViewController: UIViewController, SFSafariViewControllerDelegate {
    var newImage = UIImage()
    let wiki = WikiAPIManger()
    var des: String = ""
    
    
    
    func showPages(_ url: URL) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
        
    }
    
    
    
    @IBOutlet weak var NameLabel: UILabel!
    //从 PhotoDetailsViewController 传值过来
    @IBAction func WikiPressed(_ sender: Any) {
           //   showPages(url)
        
    }
    //从 PhotoDetailsViewController 传值过来
    @IBAction func SharePressed(_ sender: Any) {
        if let image = UIImage(named: "myImage") {
            let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
            present(vc, animated: true)
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
