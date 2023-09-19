//
//  LoadResourceView.swift
//  MovieiOS
//
//  Created by Belkhadir Anas on 19/9/2023.
//

import SwiftUI

public struct LoadResourceView<ViewModel: ResourceLoadable & ObservableObject >: View {
    @ObservedObject private var viewModel: ViewModel
    public typealias ResourceView = (ViewModel.Resource) -> AnyView
    public typealias ErrorView = (Error) -> AnyView
    
    private let view: ResourceView
    private let errorView: ErrorView
    
    public init(
        viewModel: ViewModel,
        view: @escaping ResourceView,
        errorView: @escaping ErrorView
    ) {
        self.viewModel = viewModel
        self.view = view
        self.errorView = errorView
    }
    
    public var body: some View {
        Group {
            switch viewModel.state {
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                case .loaded(let resource):
                    view(resource)
                case .failed(let error):
                    errorView(error)
                case .none:
                    Text("No data to present")
            }
        }.onAppear(perform: { viewModel.loadResource() })
    }
}
