//
//  APIBaseOperation.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import Foundation

typealias APIOperationResult<Response: APIParseable> = Result<Response, APIError>

struct APIBaseOperation: APIOperation {
  let request: APIRequest
  let sessionManager: APIOperationSession
  
  init(_ request: APIRequest, _ sessionManager: APIOperationSession = URLSession.shared) {
    self.request = request
    self.sessionManager = sessionManager
  }
  
  func startRequest<Response: APIParseable>(completionHandler: ((APIOperationResult<Response>)->Void)?) {
    sessionManager.startRequest(withOperation: self) { result in
      switch result {
      case .success(let data):
        let jsonDecoder = JSONDecoder()
        do {
          let responseObject = try jsonDecoder.decode(Response.self, from: data)
          completionHandler?(.success(responseObject))
        } catch {
          completionHandler?(.failure(.invalidResponse))
        }
      case .failure(let err):
        completionHandler?(.failure(err))
      }
    }
  }
}
