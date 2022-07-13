import Foundation

protocol MoviesRepository {
    @discardableResult
    func fetchMoviesList(query: MovieQuery, page: Int,
                         completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}
