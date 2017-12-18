//
//  FavoriteTableViewController.swift
//  What
//
//  Created by Will on 12/18/17.
//  Copyright © 2017 Will. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {
    let userDefault = UserDefaults.standard

    @IBOutlet weak var Fav: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Fav.text = "Favourite"

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteCell
       //  let fnumber = userDefault[indexPath.row]
       
        //还原对象
        //label
        let stringValue = userDefault.string(forKey: "String")
        
        //UIImage
        let objData = userDefault.data(forKey: "imageData")
        let myImage = NSKeyedUnarchiver.unarchiveObject(with: objData!) as? UIImage
        
        cell.FavouriteImage.image = myImage
        cell.FavouriteLabel.text = stringValue
        
        
        // Configure the cell...

        return cell
    }
    
  

}
