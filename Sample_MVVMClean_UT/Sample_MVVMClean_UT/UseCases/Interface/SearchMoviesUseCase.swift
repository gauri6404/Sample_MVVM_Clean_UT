import Foundation

protocol SearchMoviesUseCase {
    func execute(requestValue: SearchMoviesUseCaseRequestValue,
                 completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}
