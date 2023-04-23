//
//  Character.swift
//  rickandmorty
//
//  Created by Mete Varol on 17.04.2023.
//

import Foundation

struct Character: Identifiable, Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: LocationStruct
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
       
       var formattedCreatedDate: String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
           dateFormatter.locale = Locale(identifier: "en_US_POSIX")
           
           if let date = dateFormatter.date(from: created) {
               dateFormatter.dateFormat = "d MMM yyyy, HH:mm:ss"
               return dateFormatter.string(from: date)
           }
           
           return created
       }
    // Örnek bir karakter oluşturmak için özel bir başlatıcı ekleyin
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct LocationStruct: Codable {
    let name: String
    let url: String
}


