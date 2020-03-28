//
//  DataManager.swift
//  KokushevAV_HW2.10
//
//  Created by Александр Кокушев on 26.03.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//
import UIKit

class SharesDataManager {
    
    static let shared = SharesDataManager()
    init() {}
    
    private var rawData: SharesTable?
    var user: UserProfile?
    
    //Обработать возвраты
    func getJsonShareData(stringData: String) -> SharesTable?{
        let rawUrl = "https://iss.moex.com/iss/history/engines/stock/markets/shares/boards/tqbr/securities.json?iss.only=history&iss.meta=off&history.columns=TRADEDATE,SHORTNAME,SECID,CLOSE&date=\(stringData)"
        
        guard let url = URL(string: rawUrl) else { return nil }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                self.rawData = try decoder.decode(SharesTable.self, from: data)
            } catch let error {
                print(error)
            }
        }.resume()
        print(self.rawData)
        return rawData
    }
    
    func getProfile(completionHandlers: @escaping (UserProfile) -> Void ){
        let rawUrl = "http://dep.komandor-russia.ru/apijson.php"
        
        guard let url = URL(string: rawUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(UserProfile.self, from: data)
                completionHandlers(user)
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func getUserPhoto(photoURL: String, completionHandlers: @escaping (Data) -> Void) {
        guard let imageURL = URL(string: photoURL) else { return }
        guard let imageData = try? Data(contentsOf: imageURL) else { return }
        completionHandlers(imageData)
    }
}

