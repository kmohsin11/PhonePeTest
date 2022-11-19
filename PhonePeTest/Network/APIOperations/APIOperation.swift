//
//  APIOperation.swift
//  PhonePeTest
//
//  Created by MK on 19/11/22.
//

import Foundation

protocol APIOperation {
  var request: APIRequest { get }
  var sessionManager: APIOperationSession { get }
}

