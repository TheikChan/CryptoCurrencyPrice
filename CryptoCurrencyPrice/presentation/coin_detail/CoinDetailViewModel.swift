//
//  CoinDetailViewModel.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 18/07/2024.
//

import Foundation
import Combine

protocol CoinDetailViewModel: AnyObject {
    func getCoinDetail()
    
    func navigateToCoinWebsite()
}

final class CoinDetailViewModelImpl: CoinDetailViewModel {
    
    public let errorSubject = PassthroughSubject<String?, Never>()
    public let coinDetailSubject = PassthroughSubject<CoinDetail?, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var coinDetail: CoinDetail?
    
    private let coordinator: CoinDetailCoordinator
    private let coinRepo: CoinRepository
    private let coinUuid: String
    
    init(coordinator: CoinDetailCoordinator, coinRepo: CoinRepository, coinUuid: String) {
        self.coordinator = coordinator
        self.coinRepo = coinRepo
        self.coinUuid = coinUuid
    }
}

extension CoinDetailViewModelImpl {
    func getCoinDetail() {
        coinRepo.getCoinDetail(uuid: self.coinUuid)
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
            
            self.coinDetail = response.data?.coin
            self.coinDetailSubject.send(response.data?.coin)
        })
        .store(in: &self.subscriptions)
    }
    
    func navigateToCoinWebsite() {
        guard let website = coinDetail?.websiteUrl else { return }
        coordinator.navigateToCoinWebsite(url: website)
    }
}
