//
//  PlaylistViewModel.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class PlaylistViewModel {
  
  let playlistData = BehaviorRelay<[PlaylistDataModel]?>(value: [])
  let selectedMovie: MovieModel
  
  init(_ selectedMovie: MovieModel) {
    self.selectedMovie = selectedMovie
  }
  
  func fetchPlaylists() {
    if let data = UserDefaults.standard.object(forKey: "playlists") as? Data,
       let arr = try? JSONDecoder().decode([PlaylistDataModel].self, from: data) {
      playlistData.accept(arr)
    }
  }
  
  func addMovieToPlaylist(_ index: Int) {
//    if let map = UserDefaults.standard.value(forKey: "playlist-map") as? [Int: [UUID]], let id = selectedMovie.id, var res = map[id] {
//      let playlists = playlistData.value ?? []
//      let playlist = playlists[index]
//      res.append(playlist.id)
//      UserDefaults.standard.set([id: res], forKey: "playlist-map")
//    } else {
//      let playlists = playlistData.value ?? []
//      let playlist = playlists[index]
//      UserDefaults.standard.set([selectedMovie.id: [playlist.id]], forKey: "playlist-map")
//    }
  }
  
  func createNewPlaylist(_ name: String) {
    guard name.count > 0 else { return }
    var currentList = playlistData.value ?? []
    guard !currentList.contains(where: {$0.name == name}) else { return }
    currentList.append(PlaylistDataModel(id: UUID(), name: name))
    playlistData.accept(currentList)
    if let encoded = try? JSONEncoder().encode(currentList) {
      UserDefaults.standard.set(encoded, forKey: "playlists")
    }
  }
}
