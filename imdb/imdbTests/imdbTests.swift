//
//  imdbTests.swift
//  imdbTests
//
//  Created by Saqib Ali on 17/04/2022.
//

import XCTest
@testable import imdb

class imdbTests: XCTestCase {

    var mockWorker: MovieListMockWorker!
    var presenter : MoviesPresenter!
    var interactor: MoviesInteractor!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWorkerSuccess() throws {
        let work = MovieListMockWorker(fileName: "IMDBFixture")
        let request = Movies.Movie.Request(page: 1)
        work.fetchMoviesList(request: request) { result in
            switch result {
                case .success(let response):
                    XCTAssertEqual(response.page, 1, "checking page number")
                case .failure(let error):
                    XCTFail(error.localizedDescription)
            }
        }
    }

    func testListE2ESuccess() throws {
        mockWorker = MovieListMockWorker(fileName: "IMDBFixture")
        interactor = MoviesInteractor(worker: mockWorker)
        presenter  = MoviesPresenter()
        interactor.presenter = presenter
        let viewController = MovieListMockViewController()
        presenter.viewController = viewController
        let request = Movies.Movie.Request(page: 1)
        interactor.fetchMovies(request: request)
        
        XCTAssertEqual(viewController.viewModel.movies.count, 20, "Checkig total count")
    }

    func testWorkerFailure() throws {
        
        let expectation = self.expectation(description: "Fetching Result")
        
        var repsonseResult : Movies.Movie.Response?
        let work = MoviesWorker(service: Network())
        let request = Movies.Movie.Request(page: 0)
        work.fetchMoviesList(request: request) { result in
            switch result {
                case .success(let response):
                    repsonseResult = response
                case .failure(let error):
                    XCTAssertNotNil(error.localizedDescription, "Should Not be nil")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        if let response  =  repsonseResult {
            XCTAssertTrue(response.totalResults > 0, "Responses Fetched")
        }
    }
}
