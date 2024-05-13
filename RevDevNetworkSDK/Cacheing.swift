//
//  NetworkCache.swift
//  Medico
//
//  Created by Amit Kumar on 07/05/24.
//

import Foundation

/// The protocol for caching network responses.
public protocol CacheProtocol {
    
    /// Retrieves the cached response for the specified request.
    ///
    /// - Parameter request: The request for which to retrieve the cached response.
    /// - Returns: The cached response, if available.
    func cachedResponse(for request: URLRequest) -> CachedURLResponse?
    
    /// Stores the provided cached response for the specified request.
    ///
    /// - Parameters:
    ///   - cachedResponse: The cached response to store.
    ///   - request: The request for which to store the cached response.
    func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest)
    
    /// Sets the memory capacity of the cache.
    ///
    /// - Parameter capacity: The memory capacity in bytes.
    func setMemoryCapacity(_ capacity: Int)
    
    /// Flushes the cache, removing all cached responses.
    func flushCache()
}


public final class URLCacheWrapper: CacheProtocol {
    
    /// The wrapped URLCache instance.
    fileprivate let cache: URLCache
    
    /// Initializes a new instance of URLCacheWrapper with the specified URLCache instance.
    ///
    /// - Parameter cache: The URLCache instance to wrap. Defaults to URLCache.shared.
    public init(cache: URLCache = .shared) {
        self.cache = cache
    }

    // Implementations of CacheProtocol methods...
    public func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        return cache.cachedResponse(for: request)
    }

    public func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        cache.storeCachedResponse(cachedResponse, for: request)
    }
    // Set own memory capacity in bytes
    // eg:-  URLCache(memoryCapacity: 50 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: nil)
    public func setMemoryCapacity(_ capacity: Int) {
        cache.memoryCapacity = capacity
    }
    
    public func flushCache() {
        cache.removeAllCachedResponses()
    }
}

/// A cache protocol implementation that does not cache responses.
public final class NoCache: CacheProtocol {
    
    /// Retrieves the cached response for the specified request.
    ///
    /// - Parameter request: The request for which to retrieve the cached response.
    /// - Returns: Always returns nil.
    public func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        return nil
    }
    
    /// Stores the provided cached response for the specified request.
    ///
    /// - Parameters:
    ///   - cachedResponse: The cached response to store.
    ///   - request: The request for which to store the cached response.
    public func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        // No-op
    }
    
    /// Sets the memory capacity of the cache. This operation has no effect for NoCache.
    ///
    /// - Parameter capacity: The memory capacity in bytes.
    public func setMemoryCapacity(_ capacity: Int) {
    }
    
    /// Flushes the cache, removing all cached responses. This operation has no effect for NoCache.
    public func flushCache() {
    }
}


