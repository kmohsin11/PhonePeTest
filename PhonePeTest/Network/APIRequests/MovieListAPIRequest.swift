//
//  MovieListAPIRequest.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import Foundation

struct MovieListAPIRequest: APIRequest {
  let type: APIRequestType = .get
  let page: Int
  var url: URL? {
    return URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=\(page)")
  }
}
