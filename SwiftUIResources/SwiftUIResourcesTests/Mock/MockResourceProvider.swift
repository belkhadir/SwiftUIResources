//
//  MockResourceProvider.swift
//  SwiftUIResourcesTests
//
//  Created by Belkhadir Anas on 20/9/2023.
//

import SwiftUIResources

final class MockResourceProvider: ResourceProviding {
    typealias Resource = String

    var stubbedResult: Result<String, Error>?
    
    // Intentionally create a property to retain the last closure
    var retainedClosure: ((Result<String, Error>) -> Void)?
    
    func fetchResource(completion: @escaping (Result<String, Error>) -> Void) {
        retainedClosure = completion // Intentionally retaining the closure
        if let result = stubbedResult {
            completion(result)
        }
    }
}
