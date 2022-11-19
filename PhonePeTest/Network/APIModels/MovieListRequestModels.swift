//
//  MovieListRequestModels.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import Foundation

protocol APIParseable: Codable {}

struct MovieListAPIResponseModel: APIParseable {
  let results: [MovieModel]?
  let totalPages: Int?
  
  enum CodingKeys: String, CodingKey {
    case results
    case totalPages = "total_pages"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.results = try container.decodeIfPresent([MovieModel].self, forKey: .results)
    self.totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
  }
}

struct MovieModel: APIParseable {
  let id: Int?
  let posterPath: String?
  let title: String?
  let voteAverage: Double?
  let bgPath: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case posterPath = "poster_path"
    case title
    case voteAverage = "vote_average"
    case bgPath = "backdrop_path"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decodeIfPresent(Int.self, forKey: .id)
    self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
    self.title = try container.decodeIfPresent(String.self, forKey: .title)
    self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
    self.bgPath = try container.decodeIfPresent(String.self, forKey: .bgPath)
  }
}
