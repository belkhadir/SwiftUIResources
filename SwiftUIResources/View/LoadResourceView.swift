//
//  LoadResourceView.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 19/9/2023.
//

import SwiftUI

public struct LoadResourceView<ViewModel: ResourceFetching & ObservableObject>: View {
    public typealias LoadingView = () -> AnyView
    public typealias ResourceView = (ViewModel.Resource) -> AnyView
    public typealias ErrorView = (Error) -> AnyView
    public typealias DefaultView = () -> AnyView
    
    @ObservedObject private var viewModel: ViewModel
    private let loadingView: LoadingView
    private let view: ResourceView
    private let errorView: ErrorView
    private let defaultView: DefaultView
    
    public init(
        viewModel: ViewModel,
        loadingView: @escaping LoadingView,
        view: @escaping ResourceView,
        errorView: @escaping ErrorView,
        defaultView: @escaping DefaultView
    ) {
        self.viewModel = viewModel
        self.loadingView = loadingView
        self.view = view
        self.errorView = errorView
        self.defaultView = defaultView
    }
    
    public var body: some View {
        Group {
            switch viewModel.state {
                case .loading:
                    loadingView()
                case .loaded(let resource):
                    view(resource)
                case .failed(let error):
                    errorView(error)
                case .none:
                    defaultView()
            }
        }.onAppear(perform: { viewModel.fetchResource() })
    }
}
