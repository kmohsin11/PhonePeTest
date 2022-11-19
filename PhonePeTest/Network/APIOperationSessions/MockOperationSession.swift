//
//  MockOperationSession.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import Foundation

class MockOperationSession: APIOperationSession {
  let jsonFileName: String
  init(_ jsonFileName: String) {
    self.jsonFileName = jsonFileName
  }
  func startRequest(withOperation operation: APIOperation, completionHandler: ((APINetworkResult) -> Void)?) {
    if let url = Bundle(for: type(of: self)).url(forResource: jsonFileName, withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        completionHandler?(.success(data))
      } catch {
        completionHandler?(.failure(.invalidResponse))
      }
    } else {
      completionHandler?(.failure(.networkFailure))
    }
  }
}
