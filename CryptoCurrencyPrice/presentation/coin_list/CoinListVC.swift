//
//  CoinListVC.swift
//  CryptoCurrencyPrice
//
//  Created by Theik Chan on 17/07/2024.
//

import UIKit
import Combine

class CoinListVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cryptoCoinTableView: UITableView!
    @IBOutlet weak var errorView: ErrorView!
    
    private var subscriptions = Set<AnyCancellable>()
    private lazy var refreshControl = UIRefreshControl()
    
    var viewModel: CoinListViewModelImpl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        initUI()
        loadData()
    }
    
    private func loadData() {
        if viewModel?.isSearching ?? false {
            viewModel?.searchCoins(keyword: viewModel?.searchKeyword ?? "")
        }else {
            viewModel?.getCoins()
        }
    }
    
    func initUI() {
        refreshControl.addTarget(self, action: #selector(refreshCoin), for: .valueChanged)
        errorView.delegate = self
        setupSearchBar()
        setUpTableView()
    }
    
    private func setupSearchBar() {
        self.searchBar.delegate = self
        self.searchBar.placeholder = "Search"
    }
    
    func setUpTableView() {
        cryptoCoinTableView.register(UINib(nibName: CoinSectionHeaderView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: CoinSectionHeaderView.identifier)
        cryptoCoinTableView.register(UINib(nibName: InviteFriendCell.identifier, bundle: nil), forCellReuseIdentifier: InviteFriendCell.identifier)
        cryptoCoinTableView.setupTableView(CryptoCoinCell.identifier)        
        cryptoCoinTableView.delegate = self
        cryptoCoinTableView.dataSource = self
        cryptoCoinTableView.refreshControl = refreshControl
    }
    
    @objc func refreshCoin(refreshControl: UIRefreshControl) {
        self.viewModel?.clearCoin()
        self.loadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height)) && viewModel?.hasMoreCoins ?? true && !(viewModel?.isDownloadCoins ?? true) {
            loadMoreCoin()
        }
    }
    
    func loadMoreCoin() { 
        self.viewModel?.isDownloadCoins = true
        self.viewModel?.offset += self.viewModel?.limit ?? 1
        self.showPaginationLoading()
        self.loadData()
    }
    
    func showPaginationLoading() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(40), height: CGFloat(40))
        self.cryptoCoinTableView.tableFooterView = spinner
        self.cryptoCoinTableView.tableFooterView?.isHidden = false
    }
    
    func hidePaginationLoading() {
        self.cryptoCoinTableView.tableFooterView = nil
        self.cryptoCoinTableView.tableFooterView?.isHidden = true
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension CoinListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.displayCoinList.count == 0 {
            tableView.setEmptyMessage()
        }else {
            tableView.restore()
        }
        return viewModel?.displayCoinList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel?.isDisplayInviteFriend(index: indexPath.row + 1) == true {
            return self.tableView(tableView, inviteFriendCellForRowAt: indexPath)
        }else {
            return self.tableView(tableView, coinCellForRowAt: indexPath)
        }
    }
    
    private func tableView(_ tableView: UITableView, coinCellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CryptoCoinCell.identifier, for: indexPath) as? CryptoCoinCell {
            guard let coinItem = viewModel?.displayCoinList[indexPath.row] else {
                return UITableViewCell()
            }
            cell.displayCoin(coin: coinItem)
            return cell
        }
        return UITableViewCell()
    }
    
    private func tableView(_ tableView: UITableView, inviteFriendCellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: InviteFriendCell.identifier, for: indexPath) as? InviteFriendCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel?.isDisplayInviteFriend(index: indexPath.row + 1) == true {
            self.inviteFriend()
        }else {
            guard let coinItem = viewModel?.displayCoinList[indexPath.row] else { return }
            viewModel?.displayCoinDetail(coin: coinItem)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (viewModel?.displayCoinList ?? []).isEmpty ? 0 : viewModel?.isSearching ?? false ? 40.0 : 250.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if viewModel?.isSearching ?? false {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CoinSectionHeaderView.identifier ) as? CoinSectionHeaderView else {
                return nil
            }
            return headerView
        }else {
            let topRankHeader = TopCoinRankView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 250.0))
            topRankHeader.delegate = self
            topRankHeader.topRankCoinList = viewModel?.topRankCoinList
            return topRankHeader
        }
    }
    
    func inviteFriend() {
        let appName = "CryptoCurrencyPrice"
        let applink = "https://lmwn.com"
        let message = "Hey, I'm using \(appName). Join me! Download it here: \(applink)"
        let activityViewController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: TopCoinRankViewDelegate

extension CoinListVC: TopCoinRankViewDelegate {
    func onTapRankCoin(coin: CoinResponse) {
        viewModel?.displayCoinDetail(coin: coin)
    }
}


//MARK: - UISearchBarDelegate

extension CoinListVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)  
        viewModel?.isSearching = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchKeyword = searchText      
        if !searchText.isEmpty {
            viewModel?.clearCoin()
            viewModel?.searchCoins(keyword: searchText)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
        viewModel?.isSearching = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        viewModel?.isSearching = false
    }
}

// MARK: TopCoinRankViewDelegate

extension CoinListVC: ErrorViewDelegate {
    func onTapTryAgain() {
        self.loadData()
    }
}

extension CoinListVC {
    func bindViewModel() {
        viewModel?.errorSubject.subscribe(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let self else { return }
                
                self.cryptoCoinTableView.isHidden = true
                self.errorView.isHidden = false
            }
            .store(in: &subscriptions)

        viewModel?.coinListSubject.subscribe(on: DispatchQueue.main)
            .sink { [weak self] coinList in
                guard let self else { return }
                
                self.refreshControl.endRefreshing()
                self.hidePaginationLoading()
                self.errorView.isHidden = true
                self.cryptoCoinTableView.isHidden = false
                
                self.cryptoCoinTableView.reloadData()
            }
            .store(in: &subscriptions)
    }
}
