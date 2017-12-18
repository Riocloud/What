//
//  SearchTimeViewController.swift
//  What
//
//  Created by Will on 12/17/17.
//  Copyright © 2017 Will. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class  SearchTimeViewController : TWTRTimelineViewController {
   
    
    
    convenience init() {
        let client = TWTRAPIClient()
        let dataSource = TWTRSearchTimelineDataSource(searchQuery: "#helloworld", apiClient: client)
        self.init(dataSource: dataSource)
        
        // Show Tweet actions
        self.showTweetActions = true
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient()
        self.dataSource = TWTRListTimelineDataSource(listSlug: "surfing", listOwnerScreenName: "stevenhepting", apiClient: client)
}
}
