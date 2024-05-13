//
//  NetworkServices.swift
//  Medico
//
//  Created by Amit Kumar on 07/05/24.
//

import Foundation

/// The NetworkService class provides methods for performing network requests.
public final class NetworkService: NetworkServiceProtocol {
  
    /// The URLSession used for network requests.
    internal var session: URLSession
    
    /// The cache for storing cached responses.
    private let cache: CacheProtocol?
    
    /// The JSON decoder for decoding JSON responses.
    private let decoder: JSONDecoder
    
    /// The HTTP headers to include in requests.
    private let headers: [String: String]?
    
    /// The timeout interval for network requests.
    private let timeoutInterval: TimeInterval
    
    /// The retry policy for failed network requests.
    private let retryPolicy: RetryPolicy?
    
    /// Custom delegate
    private let networkDelegate = NetworkDelegate()

    /// Initializes a new instance of NetworkService with the specified configuration options.
    ///
    /// - Parameters:
    ///   - cache: The cache for storing cached responses. Defaults to URLCacheWrapper().
    ///   - decoder: The JSON decoder for decoding JSON responses. Defaults to JSONDecoder().
    ///   - headers: The HTTP headers to include in requests. Defaults to nil.
    ///   - timeoutInterval: The timeout interval for network requests. Defaults to 30 seconds.
    ///   - retryPolicy: The retry policy for failed network requests. Defaults to nil.
    public init(networkDelegate: URLSessionDelegate = NetworkDelegate(),
         cache: CacheProtocol? = URLCacheWrapper(),
         decoder: JSONDecoder = JSONDecoder(),
         headers: [String: String]? = nil,
         timeoutInterval: TimeInterval = 30,
         retryPolicy: RetryPolicy? = nil) {
        self.cache = cache
        self.decoder = decoder
        self.headers = headers
        self.timeoutInterval = timeoutInterval
        self.retryPolicy = retryPolicy
        
        // Configure URLSession based on parameters
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutInterval
        configuration.httpAdditionalHeaders = headers
        self.session = URLSession(configuration: configuration, delegate: networkDelegate, delegateQueue: nil)
        

    }

    public func fetchData<T: Decodable>(url: URL, headers: [String: String]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let headers = headers {
            headers.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let cachedResponse = cache?.cachedResponse(for: request), let decoded = try? decoder.decode(T.self, from: cachedResponse.data) {
            completion(.success(decoded))
            return
        }
        
        
        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self, let data = data, let response = response, error == nil else {
                completion(.failure(error ?? NSError(domain: "NetworkServiceError", code: -1, userInfo: nil)))
                return
            }
            
            self.cache?.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
            
            do {
                let decoded = try self.decoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }


    public func fetchData<T: Decodable>(url: URL, headers: [String: String]? = nil) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let headers = headers {
            headers.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let cache = cache, let cachedResponse = cache.cachedResponse(for: request), let decoded = try? decoder.decode(T.self, from: cachedResponse.data) {
            return decoded
        }

        let (data, response) = try await session.data(from: url)
        self.cache?.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
        return try decoder.decode(T.self, from: data)
    }
}

/// Defines different retry policies for failed network requests.
public enum RetryPolicy {
    /// No retry policy. Failed requests are not retried.
    case none
    
    /// Fixed retry policy with a maximum number of retries and fixed interval between retries.
    case fixed(maxRetries: Int, interval: TimeInterval)
    
    /// Exponential backoff retry policy with a maximum number of retries, initial delay, multiplier, and maximum delay between retries.
    case exponentialBackoff(maxRetries: Int, initialDelay: TimeInterval, multiplier: Double, maxDelay: TimeInterval)
    
}

