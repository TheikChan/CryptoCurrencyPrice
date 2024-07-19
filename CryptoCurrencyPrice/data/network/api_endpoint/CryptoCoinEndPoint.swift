//
//  CryptoCoinEndPoint.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import Foundation
import Alamofire

enum CryptoCoinEndPoint: APIEndPoint {
    
    case getCoins(pagination: PaginationMeta)
    case searchCoins(pagination: PaginationMeta,keyword: String)
    case coinDetail(uuid: String)
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .getCoins, .searchCoins:
            return "/v2/coins"
        case .coinDetail(let uuid):
            return "/v2/coin/\(uuid)"
        }
    }
    
    var headers: HTTPHeaders {
        return ["Content-Type": "application/json",
                "x-access-token": apiKey]
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getCoins(let pagination):
            return ["limit": pagination.limit,
                    "offset": pagination.offset]
        case .searchCoins(let pagination, let keyword):
            return ["limit": pagination.limit,
                    "offset": pagination.offset,
                    "search": keyword]
        default:
            return [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.timeoutInterval = 60.0
        urlRequest.method = httpMethod
        urlRequest.headers = self.headers
        return try Alamofire.URLEncoding.queryString.encode(urlRequest, with: self.parameters)
    }
}
