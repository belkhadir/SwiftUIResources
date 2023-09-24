//
//  ResourceFetching.swift
//  SwiftUIResources
//
//  Created by Belkhadir Anas on 24/9/2023.
//

public protocol ResourceFetching {
    associatedtype Resource: Equatable
    
    var state: ResourceState<Resource> { get }
    func fetchResource()
}
