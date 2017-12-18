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
    var ImageShare = UIImage()
    let wiki = WikiAPIManger()
    var desc = String()
    
    
    
    func noValue(){
        let alertVC = UIAlertController(
            title: "No Value",
            message: "Sorry, no value from previous",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    //Share function
    func showPages(_ url: URL) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
        
    }
    
    
    @IBAction func FavouritePressed(_ sender: Any) {
        
    }
    
    @IBOutlet weak var NameLabel: UILabel!
    
    
    @IBOutlet weak var wikiText: UITextView!
    
    
    //从 PhotoDetailsViewController 传值过来
    @IBAction func WikiPressed(_ sender: Any) {
        //   showPages(url)
        //  NameLabel =
       
    }
    //从 PhotoDetailsViewController 传值过来
    @IBAction func SharePressed(_ sender: Any) {
        let vc = UIActivityViewController(activityItems: [ImageShare], applicationActivities: [])
        present(vc, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NameLabel.text = desc
        print(desc)
       wiki.getExtract(title: desc)
            .onSuccess{ extract in
                if let extract = extract{
                    print("kksqsw")
                    print(extract)
                    self.wikiText.text = extract
                }
                else {
                    self.noValue()
                }
        }
    }
    
}

