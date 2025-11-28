//
//  User.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 19/11/25.
//

struct User: Codable, Hashable, Identifiable, Equatable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
