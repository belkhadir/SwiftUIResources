# Swift Resource Loader

This repository offers a SwiftUI-based approach for loading resources asynchronously and managing the associated UI states. Built with flexibility in mind, it allows developers to handle loading, success, error, and default states with ease.

## Features

- **ResourceService Protocol**: Define how resources should be retrieved.
- **ResourceState Enum**: Manage the different states of resource loading (`none`, `loading`, `loaded`, and `failed`).
- **LoadResourceView**: A SwiftUI view that reacts to different resource states, showing appropriate UI for each state.
- **ResourceFetching Protocol**: Protocol that any ViewModel should conform to if it is responsible for fetching resources.
- **ResourceViewModel**: A ready-to-use ViewModel designed to work with any resource provider conforming to `ResourceProviding`.

## Usage

1. **Define Your ResourceService**
```swift
struct MyResourceService: ResourceService {
    func retrieveResource(completion: @escaping (Result) -> Void) {
        // Your logic to retrive the resource
    }
}
```

2 **Create Your ViewModel**
```swift
let viewModel = ResourceViewModel(service: MyResourceService())
```

3 **Construct Your UI**
```swift
LoadResourceView(
    viewModel: viewModel,
    loadingView: { ... },   // Define your loading UI
    view: { resource in ... }, // Define UI for when resource is loaded
    errorView: { error in ... }, // Define UI for when loading fails
    defaultView: { ... }    // Default UI when no data is loaded
)
```
