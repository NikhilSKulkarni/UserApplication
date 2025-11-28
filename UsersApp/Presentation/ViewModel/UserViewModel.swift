//
//  UserViewModel.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 19/11/25.
//
import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let userUseCase: GetUsersUseCaseProtocol
    
    init(userUseCase: GetUsersUseCaseProtocol) {
        self.userUseCase = userUseCase
    }
    
    func fetchUsers() async {
        isLoading = true
        do {
            users = try await userUseCase.executeUsers()
        } catch let error as APIError {
            errorMessage = error.localizedDescription
        } catch {
            //
        }
        isLoading = false
    }
}
