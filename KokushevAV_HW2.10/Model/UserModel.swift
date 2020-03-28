//
//  UserModel.swift
//  KokushevAV_HW2.10
//
//  Created by Александр Кокушев on 27.03.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//

struct UserProfile: Decodable {
    let name: String
    let surName: String
    let age: Int
    let avatar: String
    var balance: Double
    var assets: [Portfolio]
    
    var fullName: String {
            "\(surName) \(name)"
    }
}

struct Portfolio: Decodable {
    var name: String
    var share: [Share]
}

struct Share: Decodable {
    
    let shortName: String
    let dealDate: String
    let fullName: String
    let price: Double
    
}
