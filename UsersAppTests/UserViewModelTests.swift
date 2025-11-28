//
//  UserViewModelTest.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 28/11/25.
//

import XCTest
@testable import UsersApp


// MARK: - Mock Use Case
class MockUserRepository: UserRepository {
    var shouldThrowError = false
    func getUsers() async throws -> [User] {
        if shouldThrowError {
            throw APIError.invalidResponse
        }
        let mockService = MockAPIService()
        mockService.mockFileName = "GetUserSuccess"
        return try await mockService.fetch(requestUrl: URL(string:"https://abc.com")!)
    }
}

@MainActor
final class UserViewModelTests: XCTestCase {
    var mockRepository: MockUserRepository!
    var viewModel: UserViewModel!
    
    override func setUp() {
        mockRepository = MockUserRepository()
        let useCase = GetUsersUseCase(userRepository: mockRepository)
        viewModel = UserViewModel(userUseCase: useCase)
    }
    
    override func tearDown() {
        mockRepository = nil
        viewModel = nil
    }
    
    // MARK: - Test Success Scenario
    func testLoadUsersSuccess() async {
        // Given
        mockRepository.shouldThrowError = false
        
        // When
        await viewModel.fetchUsers()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.users.count, 2)
        XCTAssertEqual(viewModel.users.first?.name, "John")
    }
    
    // MARK: - Test Error Scenario
    func testLoadUsersError() async {
        // Given
        mockRepository.shouldThrowError = true
        
        // When
        await viewModel.fetchUsers()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.users.isEmpty)
    }
}
