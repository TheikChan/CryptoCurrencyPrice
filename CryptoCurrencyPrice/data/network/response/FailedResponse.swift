//
//  FailedResponse.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import Foundation

enum FailedType: String, Codable {
    case unavailable = "REFERENCE_UNAVAILABLE"
    case validationFailed = "VALIDATION_ERROR"
    case notFound = "COIN_NOT_FOUND"
}

struct FailedResponse: Decodable {
    var status: ResponseStatus?
    var type: FailedType?
    var message: String?
}

//{
//  "status": "fail",
//  "type": "REFERENCE_UNAVAILABLE",
//  "message": "Reference currency with UUID of HxDUgYGNAdQz not available"
//}
