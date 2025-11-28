//
//  Untitled.swift
//  UsersApp
//
//  Created by Nikhil Subhash Kulkarni on 19/11/25.
//
import Foundation

protocol APIProtocol {
    func fetch<T: Decodable>(requestUrl: URL) async throws -> T
}

class APIService: APIProtocol {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
   
    func fetch<T>(requestUrl: URL) async throws -> T where T : Decodable {
      let (data, response) = try await session.data(from: requestUrl)
       
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let data = try JSONDecoder().decode(T.self, from: data)
            return data
        } catch {
            throw APIError.decodingFailed
        }
    }
}
