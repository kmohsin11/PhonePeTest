//
//  MovieListViewModel.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class MovieListViewModel {
  
  let movieData = BehaviorRelay<[MovieModel]?>(value: [])
  let playlistData = BehaviorRelay<[MovieModel]?>(value: [])
  
  func fetchMovies() {
    let operation = APIBaseOperation(MovieListAPIRequest(page: 1), MockOperationSession("movie-list"))
    operation.startRequest { [weak self] (result: Result<MovieListAPIResponseModel, APIError>) in
      switch result {
      case .success(let movies):
        self?.movieData.accept(movies.results ?? [])
      case .failure(let err):
        print(err)
      }
    }
  }
  
  func fetchPlaylistData() -> [String] {
    if let data = UserDefaults.standard.object(forKey: "playlists") as? Data,
       let arr = try? JSONDecoder().decode([PlaylistDataModel].self, from: data) {
      return arr.map({$0.name})
    }
    return []
  }
}
