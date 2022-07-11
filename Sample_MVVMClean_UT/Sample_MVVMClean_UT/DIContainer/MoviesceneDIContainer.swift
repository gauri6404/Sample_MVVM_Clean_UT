//
//  MoviesSceneDIContainer.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 03.03.19.
//

import UIKit
import SwiftUI

final class MoviesSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    // MARK: - Persistent Storage
    lazy var moviesQueriesStorage: MoviesQueriesStorage = UserDefaultsMoviesQueriesStorage(maxStorageLimit: 10)
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Repositories
    func makeMoviesRepository() -> MoviesRepository {
        return DefaultMoviesRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    func makeMoviesQueriesRepository() -> MoviesQueriesRepository {
        return DefaultMoviesQueriesRepository(dataTransferService: dependencies.apiDataTransferService,
                                              moviesQueriesPersistentStorage: moviesQueriesStorage)
    }
    func makePosterImagesRepository() -> PosterImagesRepository {
        return DefaultPosterImagesRepository(dataTransferService: dependencies.imageDataTransferService)
    }
    
    // MARK: - Use Cases
    func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
        return DefaultSearchMoviesUseCase(moviesRepository: makeMoviesRepository(),
                                          moviesQueriesRepository: makeMoviesQueriesRepository())
    }
    
    func makeFetchRecentMovieQueriesUseCase(requestValue: FetchRecentMovieQueriesUseCase.RequestValue,
                                            completion: @escaping (FetchRecentMovieQueriesUseCase.ResultValue) -> Void) -> UseCase {
        return FetchRecentMovieQueriesUseCase(requestValue: requestValue,
                                              completion: completion,
                                              moviesQueriesRepository: makeMoviesQueriesRepository()
        )
    }
    
    // MARK: - Flow Coordinators
    func makeMoviesSearchFlowCoordinator(navigationController: UINavigationController) -> MoviesSearchFlowCoordinator {
        return MoviesSearchFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

// MARK: - Movies List
extension MoviesSceneDIContainer: MoviesSearchFlowCoordinatorDependencies {
    func makeMoviesListViewController() -> MoviesListViewController {
        return MoviesListViewController.create(with: makeMoviesListViewModel(),
                                               posterImagesRepository: makePosterImagesRepository())
    }
    
    func makeMoviesListViewModel() -> MoviesListViewModel {
        return DefaultMoviesListViewModel(searchMoviesUseCase: makeSearchMoviesUseCase())
    }
}
