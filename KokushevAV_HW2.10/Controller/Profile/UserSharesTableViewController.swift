//
//  UserSharesTableViewController.swift
//  KokushevAV_HW2.10
//
//  Created by Александр Кокушев on 28.03.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//

import UIKit

class UserSharesTableViewController: UITableViewController {
    
    var shares: [Share]!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shares.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shareCell", for: indexPath) as! UserShareCell
        
        cell.textLabel?.text = shares[indexPath.row].fullName
        cell.price.text = "\(shares[indexPath.row].price)₽"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
