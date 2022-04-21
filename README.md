# IMBD


## System Requirement 

- iOS application is built using **Xcode 13.2.1 (13C100)**
- Minimum iOS Version **15.0**
- Testing Simulator iPhone 12

## Protocol Oriented Way 
Application is written mostly using protocols
```swift
protocol DisplayIndicatorLogic: AnyObject {
    func displayIndicator()
}
protocol MoviesBusinessLogic {
    func selectMovieObject(movieId: Int)
    func fetchMovies(request: Movies.Movie.Request)
}
protocol MoviesDataStore {
  var selectedMovieId: Int? { get set }
}
```

To build this application, I have created a **Networking Module**

```swift
public struct SuccessResponse {
    public let result: Any
    public let response: HTTPURLResponse?
}

public struct FailureResponse {
    public let error: Error
    public let response: HTTPURLResponse?
}

public enum NetworkResponse {
    case success(SuccessResponse)
    case failure(FailureResponse)
}

public protocol NetworkService {
    func execute(request: URLRequest, callback: @escaping (NetworkResponse) -> Void)
}

```

## Architecture
To build this application, I have used **VIP** architecture.

People List file structure
```swift
- MoviesPresenter
- MoviesWorker
- MoviesRouter
- MoviesModels
- MoviesViewController
- MoviesInteractor
```
MoviesViewController have a configurator to set **VIP Cycle**
```swift
 private func configure(viewController: MoviesViewController) {
        let worker = MoviesWorker(service: Network())
        let interactor = MoviesInteractor(worker: worker)
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        viewController.pageNumber = 1
    }
```

## API URL
APIURls contains the end point information
```swift
enum URLType: Equatable {
    case discover
    case movie(movieId:Int)
}
```

## Network Config
Network Config contains the following
```swift
public protocol NetworkConfig {
    var museum: APIEndpoint { get set }
}

public struct APIEndpoint {
    public let url: String
}  

```
## UnitTest
Unit test for list written in **ImdbMovieListTests**
**SearchMuseumMockWorker** mocked for testing
```swift
- testWorkerSuccess()
- testListE2ESuccess()
```

## Dependency Manager
- cocoapod is used for dependency manager

## How to Run
  ### Prerequisite  
    Make sure you have a MacBook and Xcode 13.2.1 (13C100) installed
- Download and open zip file
- Go to the nexttrainindicator folder and double click the **.xcworkspace** file
- Select 
- An Xcode project will open, press **CMD+R** to run the application
