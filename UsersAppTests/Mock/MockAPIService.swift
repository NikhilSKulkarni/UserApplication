//
//  MockAPIService.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 25/11/25.
//
import Foundation
@testable import UsersApp

// MARK: - Mock APIService
class MockAPIService: APIProtocol {
    var shouldThrowError = false
    var mockFileName: String?
    
    func fetch<T>(requestUrl: URL) async throws -> T where T : Decodable {
        if shouldThrowError {
            throw APIError.invalidResponse
        }
        
        guard let fileName = mockFileName,
              let url = Bundle(for: MockAPIService.self).url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw APIError.decodingFailed
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
