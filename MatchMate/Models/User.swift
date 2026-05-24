//
//  User.swift
//  MatchMate
//
//  Created by Priyanka on 24/05/26.
//


import Foundation

import Foundation

struct User: Codable, Identifiable {

    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String

    var status: MatchStatus = .none

    enum CodingKeys: String, CodingKey {

        case id
        case name
        case email
        case phone
        case website
    }
}
