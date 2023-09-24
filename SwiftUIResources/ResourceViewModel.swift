//
//  MoviesListViewModel.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 19/9/2023.
//

import SwiftUI

final public class ResourceViewModel<ResourceProvider: ResourceService>: ObservableObject where ResourceProvider.Resource: Equatable  {
    public typealias Resource = ResourceProvider.Resource
    
    private let service: ResourceProvider
    
    @Published private(set) public var state: ResourceState<Resource> = .none
    
    public init(service: ResourceProvider) {
        self.service = service
    }
}

// MARK: - ResourceFetching
extension ResourceViewModel: ResourceFetching {
    public func fetchResource() {
        state = .loading
        service.retrieveResource { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let resource):
                self.state = .loaded(resource)
            case .failure(let error):
                self.state = .failed(error)
            }
        }
    }
}
