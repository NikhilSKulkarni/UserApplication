//
//  UserRepositoryTests.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 19/11/25.
//

import XCTest
@testable import UsersApp

final class UserRepositoryTests: XCTestCase {
    var mockAPIService: MockAPIService!
    var userRepository: UserRepositoryImpl!
    
    override func setUp()  {
        mockAPIService = MockAPIService()
        mockAPIService.mockFileName = "GetUserSuccess"
        userRepository = UserRepositoryImpl(apiService: mockAPIService)
    }
    
    override func tearDown() {
        mockAPIService = nil
        userRepository = nil
    }
    
    // MARK: - Success Case
    func testGetUsersSuccess() async throws {
        // Given
        mockAPIService.shouldThrowError = false
        
        // When
        let users = try await userRepository.getUsers()
        
        // Then
        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users.first?.name, "John")
    }
    
    // MARK: - Error Case
    func testGetUsersError() async {
        // Given
        mockAPIService.shouldThrowError = true
        
        // When/Then
        do {
            _ = try await userRepository.getUsers()
            XCTFail("Expected an error")
        } catch {
            XCTAssertTrue(error is APIError)
        }
    }
}
