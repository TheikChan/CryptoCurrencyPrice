//
//  APIClient.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import Foundation
import Alamofire
import Combine

enum APIResponseError: Error {
    case notFound
    case validationFailed
    case networkError(error: Error)
    
    init?(rawValue: Int) {
        switch rawValue {
        case 404: self = .notFound
        case 422: self = .validationFailed
        default:
            return nil
        }
    }
    
    var rawValue: String? {
        switch self {
        case .notFound:
            return "404"
        case .validationFailed:
            return "422"
        default:
            return nil
        }
    }
}

extension AFError {
    var responseError: APIResponseError {
        .init(rawValue: self.responseCode ?? 404) ?? .notFound
    }
}

extension APIResponseError: LocalizedError {
    private var errorDescription: String {
        switch self {
        case .validationFailed:
            return "validation failed"
        case .notFound:
            return "not found"
        case .networkError(let error):
            return error.localizedDescription
        }
    }
}

class APIClient {
    
    private let queue = DispatchQueue(label: "network-queue", qos: .userInitiated, attributes: .concurrent)
    
    func request<T: Decodable>(_ endpoint: URLRequestConvertible) -> AnyPublisher<T, Error> where T: Decodable {
        do {
            let urlRequest = try endpoint.asURLRequest()
            let request = AF.request(urlRequest)
            return request
                .validate(statusCode:(200...500))
                .publishDecodable(type: T.self)
                .value()
                .mapError{ $0.responseError }
                .subscribe(on: queue)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: AFError.createURLRequestFailed(error: error)).eraseToAnyPublisher()
        }
    }
}
