//
//  Model.swift
//  KokushevAV_HW2.10
//
//  Created by Александр Кокушев on 26.03.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//
import Foundation

struct Quote {
    let date: String?
    let fullName: String?
    let secId: String?
    let price: Double?
    
}

//Попытки создать Decodable модель 
//struct SharesTable: Decodable {
//    var history: History
//
//}
//
//struct History: Decodable {
//    var data: [[Datum]]
//}
//
//enum Datum: Decodable {
//
//    case double(Double)
//    case string(String)
//    case null
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let x = try? container.decode(Double.self) {
//            self = .double(x)
//            return
//        }
//        if let x = try? container.decode(String.self) {
//            self = .string(x)
//            return
//        }
//        if container.decodeNil() {
//            self = .null
//            return
//        }
//
//        throw DecodingError.typeMismatch(Datum.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Datum"))
//    }
//
//}
//

