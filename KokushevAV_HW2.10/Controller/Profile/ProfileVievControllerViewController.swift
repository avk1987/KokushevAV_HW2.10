//
//  ProfileVievControllerViewController.swift
//  KokushevAV_HW2.10
//
//  Created by Александр Кокушев on 27.03.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//

import UIKit

class ProfileVievControllerViewController: UIViewController {

    @IBOutlet var fullName: UILabel!
    @IBOutlet var age: UILabel!
    @IBOutlet var balance: UILabel!
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var userLabelsStack: UIStackView!
    @IBOutlet var userAssetsTableView: UITableView!
    
    private var userProfile: UserProfile? {
        didSet {
            guard let profile = userProfile else { return }
            loadProfile(user: profile)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userAssetsTableView.dataSource = self
        userLabelsStack.isHidden.toggle()
        avatar.layer.borderColor = UIColor.black.cgColor
        avatar.layer.cornerRadius = avatar.frame.height / 2
        avatar.layer.borderWidth = 2
        
        SharesDataManager.shared.getProfile(completionHandlers: { user in
            DispatchQueue.main.async {
                self.userProfile = user
            }
        })

    }
        

    private func loadProfile(user: UserProfile) {
        
        fullName.text = user.fullName
        age.text = String(user.age)
        balance.text = String(user.balance)
        userLabelsStack.isHidden = false
        userAssetsTableView.reloadData()
        loadUserAvatar(user: user)
    }
    
    private func loadUserAvatar(user: UserProfile){
        
        SharesDataManager.shared.getUserPhoto(photoURL: user.avatar, completionHandlers: { data in
            let avatar = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.avatar.image = avatar!
            }
        })
        
    }
    
    
    private func getYesterdayDateString() -> String {
        let now = Date() // сегодня
        let yesterday = now - (60*60*24)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return(dateFormatter.string(from: yesterday))
        
    }

}

extension ProfileVievControllerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProfile?.assets.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userPortfolioCell", for: indexPath) as! UserAssetsCell
        
        guard let profile = userProfile else { return cell}
        let priceOfPortfolio = getSummOfShares(shares: profile.assets[indexPath.row].share)
        cell.textLabel?.text = profile.assets[indexPath.row].name
        cell.portfoliPriceLabel.text = "\(priceOfPortfolio)₽"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = userAssetsTableView.indexPathForSelectedRow else { return }
        guard let profile = userProfile else { return }
        
        let userSharesVC = segue.destination as! UserSharesTableViewController
        userSharesVC.shares = profile.assets[indexPath.row].share
        userSharesVC.title = profile.assets[indexPath.row].name
        userAssetsTableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    private func getSummOfShares(shares: [Share]) -> String {
        
        var sum = 0.0
        
        for share in shares {
            sum += share.price
        }
         
        return String(format: "%.2f", sum)
    }
}
