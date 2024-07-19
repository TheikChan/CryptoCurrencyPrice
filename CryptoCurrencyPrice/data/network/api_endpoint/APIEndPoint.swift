//
//  APIEndPoint.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import Foundation
import Alamofire

var serverBaseURL: String {
    return "https://api.coinranking.com"
}

protocol APIEndPoint: URLRequestConvertible {
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameters: [String: Any]? { get }
}

extension APIEndPoint {
    var url: String {
        return serverBaseURL + path
    }
    
    var apiKey: String {
        return "coinranking8d0009bb16f298afd133179c36e08ac204b1b0ff33a86092"
    }
}
