//
//  Location.swift
//  rickandmorty
//
//  Created by Mete Varol on 17.04.2023.
//

import Foundation

struct Location: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
            return lhs.id == rhs.id
        }
}
