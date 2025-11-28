//
//  UserRepository.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 19/11/25.
//

import Foundation

protocol UserRepository {
    func getUsers() async throws -> [User]
}

class UserRepositoryImpl: UserRepository {
    private let apiService: APIProtocol
    
    init(apiService: APIProtocol) {
        self.apiService = apiService
    }
    
    func getUsers() async throws -> [User] {
        guard let requestUrl = Endpoint.users.url else {
           throw APIError.invalidUrl
        }
        return try await apiService.fetch(requestUrl: requestUrl)
    }
}
