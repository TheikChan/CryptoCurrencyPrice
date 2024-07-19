//
//  CoinRemoteService.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import Foundation
import Combine

protocol CoinRemoteService {
    func getCoins(pagination: PaginationMeta) -> AnyPublisher<CoinListResponse, Error>
    func searchCoins(pagination: PaginationMeta, keyword: String) -> AnyPublisher<CoinListResponse, Error>
    func getCoinDetail(uuid: String) -> AnyPublisher<CoinDetailResponse,Error>
}

struct CoinRemoteServiceImpl: CoinRemoteService {
    
    let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getCoins(pagination: PaginationMeta) -> AnyPublisher<CoinListResponse, Error> {
        return apiClient.request(CryptoCoinEndPoint.getCoins(pagination: pagination))
    }
    
    func searchCoins(pagination: PaginationMeta, keyword: String) -> AnyPublisher<CoinListResponse, Error> {
        return apiClient.request(CryptoCoinEndPoint.searchCoins(pagination: pagination, keyword: keyword))
    }
    
    func getCoinDetail(uuid: String) -> AnyPublisher<CoinDetailResponse, Error> {
        return apiClient.request(CryptoCoinEndPoint.coinDetail(uuid: uuid))
    }
}
