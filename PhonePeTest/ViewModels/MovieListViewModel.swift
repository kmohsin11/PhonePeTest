//
//  MovieListViewModel.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import Foundation

class MovieListViewModel {
  func fetchMovies() {
    let operation = APIBaseOperation(MovieListAPIRequest(page: 1), MockOperationSession("movie-list"))
    operation.startRequest { (result: Result<MovieListAPIResponseModel, APIError>) in
      switch result {
      case .success(let movies):
        print(movies)
      case .failure(let err):
        print(err)
      }
    }
  }
}
