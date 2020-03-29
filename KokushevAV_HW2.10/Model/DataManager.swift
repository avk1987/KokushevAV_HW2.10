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
    
    var user: UserProfile?
    
    //Обработать возвраты
    func getJsonShareData(stringData: String, completionHandlers: @escaping ([Quote]) -> Void) {
        let rawUrl = "https://iss.moex.com/iss/history/engines/stock/markets/shares/boards/tqbr/securities.json?iss.only=history&iss.meta=off&history.columns=TRADEDATE,SHORTNAME,SECID,CLOSE&date=\(stringData)"
        
        var quotes: [Quote] = []
        
        guard let url = URL(string: rawUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let dataResponse = data else { return }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:dataResponse) as! [String: Any]
                
                guard let rootSection = jsonResponse["history"] else { return }
                let firstLine = rootSection as! [String: Any]
                let dataLine = firstLine["data"] as! [Array<Any>]
                
                for quote in dataLine {
                    let dateBuy = quote[0] as? String
                    let fullName = quote[1] as? String
                    let shortName = quote[2] as? String
                    let price = quote[3] as? Double
                    
                    quotes.append(Quote(date: dateBuy, fullName: fullName, secId: shortName, price: price))
                }
                
                completionHandlers(quotes)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
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

