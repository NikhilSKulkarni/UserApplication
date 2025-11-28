//
//  APIServiceTests.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 25/11/25.
//
import XCTest
@testable import UsersApp

final class APIServiceTests: XCTestCase {

    var apiService: APIService!
    var session: URLSession!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        apiService = APIService(session: session)
    }

    // MARK: - Success Case
    func testFetchSuccess() async throws {
        guard let url = Bundle(for: APIServiceTests.self).url(forResource: "GetUserSuccess", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw APIError.decodingFailed
        }

        MockURLProtocol.mockData = data
        MockURLProtocol.mockResponse = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                                       statusCode: 200,
                                                       httpVersion: nil,
                                                       headerFields: nil)
        MockURLProtocol.mockError = nil

        // When
        let testUrl = URL(string: "https://test.com")!
        let result: [User] = try await apiService.fetch(requestUrl: testUrl)

        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "John")
    }

    // MARK: - Invalid Response
    func testInvalidResponse() async {
        // Given
        MockURLProtocol.mockResponse = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                                       statusCode: 500,
                                                       httpVersion: nil,
                                                       headerFields: nil)
        MockURLProtocol.mockData = Data()
        MockURLProtocol.mockError = nil

        // When
        do {
            let url = URL(string: "https://test.com")!
            let _: [User] = try await apiService.fetch(requestUrl: url)
            XCTFail("Expected an error but got success")
        } catch {
            // Then
            XCTAssertTrue(error is APIError)
        }
    }

    // MARK: - Decode Error
    func testDecodeError() async {
        // Given invalid JSON
        let json = "{ invalid json }"
        MockURLProtocol.mockData = json.data(using: .utf8)
        MockURLProtocol.mockResponse = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                                       statusCode: 200,
                                                       httpVersion: nil,
                                                       headerFields: nil)

        // When
        do {
            let url = URL(string: "https://test.com")!
            let _: [User] = try await apiService.fetch(requestUrl: url)
            XCTFail("Expected decode error")
        } catch {
            // Then
            XCTAssertEqual(error as? APIError, APIError.decodingFailed)
        }
    }
}
