//
//  CoinListViewModel.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import Foundation
import Combine

protocol CoinListViewModel: AnyObject {
    func getCoins()
    func searchCoins(keyword: String)
    func isDisplayInviteFriend(index: Int) -> Bool
    
    func displayCoinDetail(coin: CoinResponse)
}

final class CoinListViewModelImpl: CoinListViewModel {
    private var subscriptions = Set<AnyCancellable>()
    
    public let errorSubject = PassthroughSubject<String?, Never>()
    public let coinListSubject = PassthroughSubject<[CoinResponse]?, Never>()
    
    var coinList: [CoinResponse] = []
    var topRankCoinList: [CoinResponse] = []
    var displayCoinList: [CoinResponse] = []
    
    var isSearching: Bool = false {
        didSet {
            if isSearching {
                searchCoinFocus()
            }else {
                searchCoinNormal()
            }
        }
    }
    var searchKeyword: String = ""
    
    let topRankCoinCount: Int = 3
    var offset: Int = 0
    var limit: Int = 10
    var hasMoreCoins: Bool = false
    var isDownloadCoins: Bool = false
    
    private let coordinator: CoinListCoordinator
    private let coinRepo: CoinRepository
    
    init(coordinator: CoinListCoordinator, coinRepo: CoinRepository) {
        self.coordinator = coordinator
        self.coinRepo = coinRepo
    }
}

extension CoinListViewModelImpl {
    
    func resetPagination() {
        self.offset = 0
        self.hasMoreCoins = false
    }
    
    func searchCoinFocus() {
        resetPagination()
        
        self.displayCoinList = self.coinList
        self.coinListSubject.send(displayCoinList)
    }
    
    func searchCoinNormal() {
        resetPagination()
                
        if topRankCoinCount < self.coinList.count {
            self.displayCoinList = Array(self.coinList[self.topRankCoinCount ..< (self.coinList.count)] )
        }else {
            self.topRankCoinList = self.coinList
            self.displayCoinList = []
        }
        self.coinListSubject.send(displayCoinList)
    }
    
    func clearCoin() {
        resetPagination()
        
        self.coinList.removeAll()
        self.topRankCoinList.removeAll()
        self.displayCoinList.removeAll()
        
        self.coinListSubject.send(displayCoinList)
    }
    
    func isDisplayInviteFriend(index: Int) -> Bool {
        var firstAdsIdx = 5
        while firstAdsIdx <= index {
            if firstAdsIdx == index {
                return true
            }
            firstAdsIdx *= 2
        }
        return false
    }
    
    func getCoins() {
        let pagination = PaginationMeta(offset: offset, limit: limit)
        coinRepo.getCoins(pagination: pagination)
        .subscribe(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] errorCompletion in
            switch errorCompletion {
            case .failure(let error):
                self?.errorSubject.send(error.localizedDescription)
            default:
                break
            }
        }, receiveValue: { [weak self] response in
            guard let self else { return }
            self.handleCoinListResponse(response: response)
        })
        .store(in: &self.subscriptions)
    }
    
    func searchCoins(keyword: String) {
        let pagination = PaginationMeta(offset: offset, limit: limit)
        coinRepo.searchCoins(pagination: pagination, keyword: keyword)            
        .subscribe(on: DispatchQueue.main)
        .sink(receiveCompletion: { [weak self] errorCompletion in
            switch errorCompletion {
            case .failure(let error):
                self?.errorSubject.send(error.localizedDescription)
            default:
                break
            }
        }, receiveValue: { [weak self] response in
            guard let self else { return }
            self.handleCoinListResponse(response: response)
        })
        .store(in: &self.subscriptions)
    }
    
    func handleCoinListResponse(response: CoinListResponse) {
        self.isDownloadCoins = false
        
        self.coinList.append(contentsOf: response.data?.coins?.sorted(by: {$0.rank ?? 0 < $1.rank ?? 0}) ?? [])
        
        if self.coinList.count < response.data?.coinStatistic?.total ?? 0 {
            self.hasMoreCoins = true
        }else {
            self.hasMoreCoins = false
        }
                
        if self.topRankCoinCount < self.coinList.count {
            self.topRankCoinList = self.topRankCoinList.isEmpty ? Array(self.coinList.prefix(self.topRankCoinCount) ) : self.topRankCoinList
            self.displayCoinList = Array(self.coinList[self.topRankCoinCount ..< (self.coinList.count)] )
        }else {
            self.topRankCoinList = self.coinList
            self.displayCoinList = []
        }
        
        self.coinListSubject.send(displayCoinList)
    }
    
    func displayCoinDetail(coin: CoinResponse) {
        guard let coinUuid = coin.uuid else { return }
        coordinator.navigateToCoinDetail(coinUuid: coinUuid)
    }
}
