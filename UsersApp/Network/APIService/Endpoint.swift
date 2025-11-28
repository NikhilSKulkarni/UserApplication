//
//  End.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 19/11/25.
//
import Foundation

enum Endpoint {
    static let baseUrl = "https://jsonplaceholder.typicode.com"
    case users
    
    var url: URL? {
        return URL(string: Endpoint.baseUrl + self.path)
    }
    
    private var path: String {
        switch self {
        case .users:
            return "/users"
        }
    }
}
