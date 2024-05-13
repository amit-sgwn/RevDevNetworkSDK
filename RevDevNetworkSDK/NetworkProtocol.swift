//
//  NetworkServices.swift
//  Medico
//
//  Created by Amit Kumar on 07/05/24.
//
import Foundation
/// The NetworkService protocol defines methods for performing network requests.
public protocol NetworkServiceProtocol {
    /// Fetches data from the specified URL asynchronously.
    ///
    /// - Parameters:
    ///   - url: The URL from which to fetch data.
    ///   - headers: Optional HTTP headers to include in the request.
    ///   - completion: A closure to call with the result of the fetch operation.
    func fetchData<T: Decodable>(url: URL, headers: [String: String]?, completion: @escaping (Result<T, Error>) -> Void)
    
    /// Fetches data from the specified URL asynchronously using async/await.
    ///
    /// - Parameters:
    ///   - url: The URL from which to fetch data.
    ///   - headers: Optional HTTP headers to include in the request.
    /// - Returns: The fetched data as a generic type T.
    func fetchData<T: Decodable>(url: URL, headers: [String: String]?) async throws -> T
}
