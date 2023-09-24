//
//  ResourceViewModelTests.swift
//  SwiftUIResourcesTests
//
//  Created by Belkhadir Anas on 20/9/2023.
//

import XCTest
import SwiftUIResources

final class ResourceViewModelTests: XCTestCase {

    func testGivenInitialState_WhenInitialized_ThenStateIsNone() {
        let (sut, _) = makeSUT()
        XCTAssertEqual(sut.state, .none)
    }
    
    func testGivenLoadingState_WhenLoadingResource_ThenStateIsLoading() {
        assertThat(givenResult: nil, expectedState: .loading)
    }
    
    func testGivenFailedState_WhenFetchFails_ThenStateIsFailed() {
        let anyError = NSError(domain: "Any error", code: 1)
        
        assertThat(givenResult: .failure(anyError), expectedState: .failed(anyError))
    }

    func testGivenLoadedState_WhenFetchSuccessful_ThenStateIsLoaded() {
        let result = "Any string data"
        
        assertThat(givenResult: .success(result), expectedState: .loaded(result))
    }
    
    func testNoRetainCycle() {
        var sut: ResourceViewModel<MockResourceService>? = makeSUT().sut
        weak var weakSUT = sut
        
        sut?.fetchResource()
        
        sut = nil
        
        XCTAssertNil(weakSUT)
    }
}

// MARK: - Helpers
private extension ResourceViewModelTests {
    func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: ResourceViewModel<MockResourceService>, resource: MockResourceService) {
        let service = MockResourceService()
        let viewModel = ResourceViewModel(service: service)
        trackForMemoryLeaks(service, file: file, line: line)
        trackForMemoryLeaks(viewModel, file: file, line: line)
        return (viewModel, service)
    }
    
    func assertThat(givenResult: Result<String, Error>?, expectedState: ResourceState<String>, file: StaticString = #file, line: UInt = #line) {
        let (sut, resource) = makeSUT()
        resource.stubbedResult = givenResult
        sut.fetchResource()
        XCTAssertEqual(sut.state, expectedState)
    }
}
