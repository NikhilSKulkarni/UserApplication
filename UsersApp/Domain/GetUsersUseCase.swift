//
//  Untitled.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 19/11/25.
//
import Foundation

protocol GetUsersUseCaseProtocol {
    func executeUsers() async throws -> [User]
}

class GetUsersUseCase: GetUsersUseCaseProtocol {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func executeUsers() async throws -> [User] {
        try await userRepository.getUsers()
    }
}
