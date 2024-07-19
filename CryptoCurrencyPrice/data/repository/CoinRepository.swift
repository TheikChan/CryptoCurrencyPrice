//
//  CoinRepository.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import Foundation
import Combine

protocol CoinRepository {
    func getCoins(pagination: PaginationMeta) -> AnyPublisher<CoinListResponse, Error>
    func searchCoins(pagination: PaginationMeta, keyword: String) -> AnyPublisher<CoinListResponse, Error>
    func getCoinDetail(uuid: String) -> AnyPublisher<CoinDetailResponse, Error>
}

struct CoinRepositoryImpl: CoinRepository {
    
    let coinRemoteService: CoinRemoteService
    
    init(coinRemoteService: CoinRemoteService) {
        self.coinRemoteService = coinRemoteService
    }
    
    func getCoins(pagination: PaginationMeta) -> AnyPublisher<CoinListResponse, Error> {
        return coinRemoteService.getCoins(pagination: pagination)
    }
    
    func searchCoins(pagination: PaginationMeta, keyword: String) -> AnyPublisher<CoinListResponse, Error>  {
        return coinRemoteService.searchCoins(pagination: pagination, keyword: keyword)
    }
    
    func getCoinDetail(uuid: String) -> AnyPublisher<CoinDetailResponse, Error> {
        return coinRemoteService.getCoinDetail(uuid: uuid)
    }
}
