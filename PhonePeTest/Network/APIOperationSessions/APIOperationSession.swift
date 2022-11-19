//
//  APIOperationSession.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import Foundation

enum APIError: Error {
  case networkFailure
  case invalidResponse
}

typealias APINetworkResult = Result<Data, APIError>

protocol APIOperationSession {
  func startRequest( withOperation operation: APIOperation, completionHandler: ((APINetworkResult)->Void)?)
}
