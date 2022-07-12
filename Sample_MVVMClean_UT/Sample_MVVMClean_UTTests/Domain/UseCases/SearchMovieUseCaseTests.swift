import XCTest

class SearchMoviesUseCaseTests: XCTestCase {

    static let moviesPages: [MoviesPage] = {
        let page1 = MoviesPage(page: 1, totalPages: 2, movies: [
            Movie.stub(id: "1", title: "title1", posterPath: "/1", overview: "overview1"),
            Movie.stub(id: "2", title: "title2", posterPath: "/2", overview: "overview2")])
        let page2 = MoviesPage(page: 2, totalPages: 2, movies: [
            Movie.stub(id: "3", title: "title3", posterPath: "/3", overview: "overview3")])
        return [page1, page2]
    }()

    enum MoviesRepositorySuccessTestError: Error {
        case failedFetching
    }

    struct MoviesRepositoryMock: MoviesRepository {
        var result: Result<MoviesPage, Error>
        func fetchMoviesList(query: MovieQuery, page: Int, completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
            completion(result)
            return nil
        }
    }

    func testSearchMoviesUseCaseRequestValue() {
        // given
        let expectation = self.expectation(description: "Recent query saved")
        let useCase = DefaultSearchMoviesUseCase(moviesRepository: MoviesRepositoryMock(result: .success(SearchMoviesUseCaseTests.moviesPages[0])))

        // when
        let requestValue = SearchMoviesUseCaseRequestValue(query: MovieQuery(query: "title1"),
                                                           page: 0)
        
        // then
        var moviePage: MoviesPage!
        _ = useCase.execute(requestValue: requestValue) { result in
            moviePage = (try? result.get())
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(moviePage != nil)
    }
}
