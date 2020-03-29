//
//  QuotesTableViewController.swift
//  KokushevAV_HW2.10
//
//  Created by Александр Кокушев on 29.03.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//

import UIKit

class QuotesTableViewController: UITableViewController {
    
    var quotes: [Quote] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        loadQuotes()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as! ListQuoteCell
        
        cell.fullNameLabel.text = quotes[indexPath.row].fullName
        cell.shortNameLabel.text = quotes[indexPath.row].secId
        cell.dateCourseLabel.text = quotes[indexPath.row].date
        cell.priceLabel.text = "\(quotes[indexPath.row].price ?? 0.00 )₽"
        
        return cell
        
    }
}

// MARK: - Load Data
extension QuotesTableViewController {
    
    func loadQuotes() {
        
        SharesDataManager.shared.getJsonShareData(stringData: "2020-03-26", completionHandlers: { quotes in
            DispatchQueue.main.async {
                self.quotes = quotes
                self.tableView.reloadData()
            }
        })
        
    }
    
}

