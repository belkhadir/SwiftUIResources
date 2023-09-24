//
//  ResourceService.swift
//  MovieCore
//
//  Created by Belkhadir Anas on 19/9/2023.
//

public protocol ResourceService {
    associatedtype Resource
    
    typealias Result = Swift.Result<Resource, Error>
    
    func retrieveResource(completion: @escaping (Result) -> Void)
}
