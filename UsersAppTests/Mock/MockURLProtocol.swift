//
//  MockURLProtocol.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 25/11/25.
//
import Foundation
@testable import UsersApp

class MockURLProtocol: URLProtocol {
    
    static var mockResponse: HTTPURLResponse?
    static var mockData: Data?
    static var mockError: APIError?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.mockError {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        
        if let response = MockURLProtocol.mockResponse {
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let data = MockURLProtocol.mockData {
            self.client?.urlProtocol(self, didLoad: data)
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
